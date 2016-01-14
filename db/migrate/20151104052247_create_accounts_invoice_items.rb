class CreateAccountsInvoiceItems < ActiveRecord::Migration
  def change
    create_table :accounts_invoice_items do |t|
      t.belongs_to :accounts_invoice, index:true
      t.string :description
      t.integer :units
      t.integer :unit_cost
      t.string :comp_action

      t.timestamps null: false
    end
  end
end
