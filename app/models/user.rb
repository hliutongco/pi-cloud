class User < ApplicationRecord
  has_many :songs
  has_many :playlists
end
