require 'spec_helper'

describe AccountsInvoice do
  it "has a valid factory" do
    expect(FactoryGirl.create(:accounts_invoice)).to be_valid
  end
  it "is invalid without an invoice date" do
    expect(FactoryGirl.build(:accounts_invoice, invoice_date: nil)).to be_invalid
  end
  it "is invalid with a bad date format" do
    expect(FactoryGirl.build(:accounts_invoice, invoice_date: 'bad date')).to be_invalid
  end
  it "is valid without invoice terms" do
    expect(FactoryGirl.build(:accounts_invoice, invoice_terms: nil)).to be_valid
  end
  it "is invalid without a currency" do
    expect(FactoryGirl.build(:accounts_invoice, currency: nil)).to be_invalid
  end
  it "returns an invoice's reference number" do
    today = Date.today
    invoice = FactoryGirl.create(:accounts_invoice, invoice_date: Faker::Date.forward(days=0))
    expect(invoice.invoice_ref).to match(today.to_formatted_s(:year_month) + '00001')
  end
  it "returns total invoice value" do
    invoice = FactoryGirl.create(:accounts_invoice_with_items)
    expect(invoice.invoice_total).to be_a Integer
  end
  it "returns VAT for invoice" do
    invoice = FactoryGirl.create(:accounts_invoice_with_items)
    expect(invoice.invoice_tax).to be_a Float
  end
end