class Song < ApplicationRecord
  include SongUploader[:url]

  belongs_to :user
  has_many :song_playlists
  has_many :playlists, through: :song_playlists

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
end
