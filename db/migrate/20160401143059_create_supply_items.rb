class CreateSupplyItems < ActiveRecord::Migration
  def change
    create_table :supply_items do |t|
      t.string :name
      t.string :code
      t.references :supply_item_category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
