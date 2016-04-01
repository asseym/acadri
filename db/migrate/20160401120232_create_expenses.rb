class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.string :item
      t.text :description
      t.date :expense_date
      t.integer :qty
      t.integer :unit_price
      t.integer :tax
      t.string :invoice_ref

      t.timestamps null: false
    end
  end
end
