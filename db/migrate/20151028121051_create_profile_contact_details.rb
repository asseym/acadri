class CreateProfileContactDetails < ActiveRecord::Migration
  def change
    create_table :profile_contact_details do |t|
      t.belongs_to :user, index: true
      t.string :address
      t.string :email_address
      t.string :business_phone
      t.string :mobile_phone
      t.string :home_phone
      t.string :fax

      t.timestamps null: false
    end
  end
end
