class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :name
      t.text :description
      t.string :asset_category
      t.integer :current_value
      t.references :country, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
