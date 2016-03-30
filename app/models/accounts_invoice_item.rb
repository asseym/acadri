class AccountsInvoiceItem < ActiveRecord::Base
  belongs_to :accounts_invoice
  validates :description, presence: true
  validates :units, presence: true, :numericality => { :greater_than_or_equal_to => 1 }
  validates :unit_cost, presence: true, :numericality => { :greater_than_or_equal_to => 0 }

  ADD_SUBTRACT_ACTIONS = [:add, :subtract]

  def to_s
    "#{description} #{units.to_s} #{unit_cost.to_s}"
  end
end
