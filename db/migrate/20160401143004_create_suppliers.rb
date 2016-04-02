class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :shop_name
      t.string :contact_numbers
      t.string :address
      t.string :town
      t.references :country, index: true, foreign_key: true
      # t.references :supply_items, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
