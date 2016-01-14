class AddAttachmentCvToProfileGeneralDetails < ActiveRecord::Migration
  def self.up
    change_table :profile_general_details do |t|
      t.attachment :cv
    end
  end

  def self.down
    remove_attachment :profile_general_details, :cv
  end
end
