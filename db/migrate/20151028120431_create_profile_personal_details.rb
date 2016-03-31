class CreateProfilePersonalDetails < ActiveRecord::Migration
  def change
    create_table :profile_personal_details do |t|
      t.belongs_to :user, index: true
      t.string :first_name
      t.string :other_names
      t.string :religion
      t.string :sex
      t.string :marital_status
      t.date :birthday
      t.string :nationality
      t.string :languages

      t.timestamps null: false
    end
  end
end
