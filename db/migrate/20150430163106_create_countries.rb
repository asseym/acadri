class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name
      t.string :c_code
      t.integer :telephone_code

      t.timestamps null: false
    end
  end
end
