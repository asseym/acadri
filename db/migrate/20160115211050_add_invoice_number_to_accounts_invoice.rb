class AddInvoiceNumberToAccountsInvoice < ActiveRecord::Migration
  def change
    add_column :accounts_invoices, :invoice_number, :integer
  end
end
