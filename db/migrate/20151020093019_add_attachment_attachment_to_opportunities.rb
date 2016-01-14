class AddAttachmentAttachmentToOpportunities < ActiveRecord::Migration
  def self.up
    change_table :opportunities do |t|
      t.attachment :attachment
    end
  end

  def self.down
    remove_attachment :opportunities, :attachment
  end
end
