class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  has_many :songs, dependent: :delete_all
  has_many :playlists, dependent: :delete_all

  has_many :active_relationships, class_name:  "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name:  "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_secure_password

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: ":style/anon.png"
  validates_attachment :avatar,
  content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }


  # # Follows a user.
  # def follow(other)
  #   active_relationships.create(followed_id: other.id)
  # end
  #
  # # Unfollows a user.
  # def unfollow(other_user)
  #   active_relationships.find_by(followed_id: other.id).destroy
  # end
  #
  # # Returns true if the current user is following the other user.
  # def following?(other)
  #   following.include?(other)
  # end

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
end
