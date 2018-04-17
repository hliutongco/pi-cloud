class CreateSongs < ActiveRecord::Migration[5.1]
  def change
    create_table :songs do |t|
      t.string :url_data
      t.string :code
      t.string :title
      t.string :genre
      t.integer :user_id
      t.timestamps
    end
  end
end
