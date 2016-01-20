class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.string :name
      t.references :category, index: true, foreign_key: true
      t.text :description
      t.boolean :is_service, default: true
      t.timestamps null: false
    end
  end
end
