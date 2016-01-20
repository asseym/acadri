class AccountsInvoice < ActiveRecord::Base
  belongs_to :training
  has_many :accounts_invoice_items
  validates :invoice_date, presence: true
  validates :currency, presence: true

  before_create :set_invoice_number
  
  ADD_SUBTRACT_ACTIONS = [:add, :subtract]

  def set_invoice_number
    last_invoice_number = AccountsInvoice.maximum(:invoice_number)
    self.invoice_number = last_invoice_number.to_i + 1
  end

  def invoice_ref
    # date_prefix = created_at.to_formatted_s(:year_month)
    date_prefix = created_at.strftime("%Y%m")
    date_prefix + invoice_number.to_s.rjust(5, '0')
  end

  def invoice_total
    total = 0
    accounts_invoice_items.each do |item|
      total += item.units * item.unit_cost
    end
    total
  end

  def invoice_tax
    taxable = 0
    accounts_invoice_items.each do |item|
      taxable += item.units * item.unit_cost
    end
    _apply_vat(taxable)
  end

  private
    def _apply_vat(val)
      tax = Settings.vat_rate.to_f / 100 * val.to_f
      tax.round(2)
    end
end
