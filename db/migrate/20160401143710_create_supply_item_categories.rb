class CreateSupplyItemCategories < ActiveRecord::Migration
  def change
    create_table :supply_item_categories do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
