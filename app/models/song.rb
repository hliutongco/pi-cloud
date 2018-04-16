class Song < ApplicationRecord
  include SongUploader[:url]

  belongs_to :user
  has_many :song_playlists
  has_many :playlists, through: :song_playlists

end
