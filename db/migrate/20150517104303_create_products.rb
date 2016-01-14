class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :actable_id
      t.string  :actable_type
      t.string :name
      t.references :category, index: true, foreign_key: true
      t.text :description
      t.boolean :product, default: false

      t.timestamps null: false
    end
  end
end
