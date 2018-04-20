class Playlist < ApplicationRecord
  validates :name, presence: true
  validates :mood, presence: true

  belongs_to :user
  has_many :song_playlists
  has_many :songs, through: :song_playlists
  has_many :playlist_comments

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

  def self.moods
    moods = []
    self.all.each do |p|
      p.mood.split(", ").each do |m|
        moods << m
      end
    end
    moods.uniq
  end

end
