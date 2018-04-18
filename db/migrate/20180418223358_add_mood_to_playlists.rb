class AddMoodToPlaylists < ActiveRecord::Migration[5.1]
  def change
    add_column :playlists, :mood, :string
  end
end
