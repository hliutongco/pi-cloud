class CreateSongs < ActiveRecord::Migration[5.1]
  def change
    create_table :songs do |t|
      t.string :file_url
      t.string :code
      t.string :title
      t.string :genre
      t.string :img

      t.timestamps
    end
  end
end
