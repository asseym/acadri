class CreateProfileGeneralDetails < ActiveRecord::Migration
  def change
    create_table :profile_general_details do |t|
      t.belongs_to :user, index: true
      t.text :education
      t.string :staff_id
      t.date :date_hired
      t.string :passport_number
      t.string :drivers_licence
      t.integer :salary
      t.string :NSSF_number

      t.timestamps null: false
    end
  end
end
