class CreateAccountsInvoices < ActiveRecord::Migration
  def change
    create_table :accounts_invoices do |t|
      t.references :training, index: true, foreign_key: true
      t.date :invoice_date
      t.text :invoice_terms
      t.string :currency

      t.timestamps null: false
    end
  end
end
