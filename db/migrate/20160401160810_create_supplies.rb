class CreateSupplies < ActiveRecord::Migration
  def change
    create_table :supplies do |t|
      t.references :supplier, index: true, foreign_key: true
      t.references :supply_item, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
