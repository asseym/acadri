class AccountsInvoice < ActiveRecord::Base
  belongs_to :training
  has_many :accounts_invoice_items
  
  ADD_SUBTRACT_ACTIONS = [:add, :subtract]
end
