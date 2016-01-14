class AddAttachmentPhotoToProfileGeneralDetails < ActiveRecord::Migration
  def self.up
    change_table :profile_general_details do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :profile_general_details, :photo
  end
end
