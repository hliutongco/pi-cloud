class CreatePlaylistComments < ActiveRecord::Migration[5.1]
  def change
    create_table :playlist_comments do |t|
      t.text :content
      t.integer :user_id
      t.integer :playlist_id 
      t.timestamps
    end
  end
end
