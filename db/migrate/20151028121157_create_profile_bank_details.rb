class CreateProfileBankDetails < ActiveRecord::Migration
  def change
    create_table :profile_bank_details do |t|
      t.belongs_to :user, index: true
      t.text :bank_details

      t.timestamps null: false
    end
  end
end
