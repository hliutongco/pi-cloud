class User < ApplicationRecord
  attr_accessor :activation_token, :reset_token
  before_create :create_activation_digest

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates_length_of :bio, :minimum => 0, :maximum => 500, :allow_blank => true

  has_many :song_comments
  has_many :playlist_comments
  has_many :songs, dependent: :delete_all
  has_many :playlists, dependent: :delete_all

  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_secure_password

  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' }, default_url: ':style/anon.png'
  validates_attachment :avatar,
                       content_type: { content_type: ['image/jpeg', 'image/gif', 'image/png'] }

  # Follows a user.
  def follow(other_user)
    following << other_user
  end

  # Unfollows a user.
  def unfollow(other_user)
    following.delete(other_user)
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  def self.sort_by_followers
    all.sort_by { |u| u.followers.count }.reverse
  end

  def self.featured
    sort_by_followers.first
  end

  def self.popular
    index = 1
    popular = []
    users = sort_by_followers
    while users[index] && index < 4
      popular << users[index]
      index += 1
    end
    popular
  end

  # EMAIL ACTIVATION/PASSWORD RESET
  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  private

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
