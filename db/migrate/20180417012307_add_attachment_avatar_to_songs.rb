class AddAttachmentAvatarToSongs < ActiveRecord::Migration[5.1]
  def self.up
    change_table :songs do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :songs, :avatar
  end
end
