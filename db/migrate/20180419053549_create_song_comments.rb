class CreateSongComments < ActiveRecord::Migration[5.1]
  def change
    create_table :song_comments do |t|
      t.text :content
      t.integer :user_id
      t.integer :song_id 
      t.timestamps
    end
  end
end
