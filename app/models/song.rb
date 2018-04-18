class Song < ApplicationRecord
  include SongUploader[:url]

  validates :title, presence: true
  validates :url, presence: true
  validates :code, presence: true

  belongs_to :user
  has_many :song_playlists
  has_many :playlists, through: :song_playlists

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: ":style/missing.png"
  validates_attachment :avatar,
  content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }




  def self.sort_by_playlists
    self.all.sort_by {|s| s.playlists.count}.reverse
  end

  def self.featured
    self.sort_by_playlists.first
  end

  def self.popular
    index = 1
    popular = []
    songs = self.sort_by_playlists
    while (songs[index] && index < 4)
      popular << songs[index]
      index += 1
    end
    popular
  end
end
