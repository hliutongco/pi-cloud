class Song < ApplicationRecord
  include SongUploader[:url]

  validates :title, presence: true
  validates :url, presence: true
  validates :code, presence: true
  validates :genre, presence: true

  belongs_to :user
  has_many :song_playlists
  has_many :playlists, through: :song_playlists

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: ":style/missing.png"
  validates_attachment :avatar,
  content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
end
