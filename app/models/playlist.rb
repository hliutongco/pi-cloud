class Playlist < ApplicationRecord
  validates :name, presence: true

  belongs_to :user
  has_many :song_playlists
  has_many :songs, through: :song_playlists

  def all_songs
    @playlist.songs
  end

  def remove_song(song_id)
    song = Song.find(song_id)
    @playlist.delete(song) if song
  end

  def add_song(song_id)
    song = Song.find(song_id)
    @playlist << song
  end
end
