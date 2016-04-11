class CreateExpenseSubCategories < ActiveRecord::Migration
  def change
    create_table :expense_sub_categories do |t|
      t.string :name
      t.references :expense_category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
