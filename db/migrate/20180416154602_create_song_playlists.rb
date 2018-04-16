class CreateSongPlaylists < ActiveRecord::Migration[5.1]
  def change
    create_table :song_playlists do |t|
      t.integer :playlist_id
      t.integer :song_id
    end
  end
end
