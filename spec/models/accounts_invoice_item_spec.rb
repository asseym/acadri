require 'rails_helper'

RSpec.describe AccountsInvoiceItem, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:accounts_invoice_item)).to be_valid
  end
  it "is invalid without a description" do
    expect(FactoryGirl.build(:accounts_invoice_item, description: nil)).to be_invalid
  end
  it "is invalid without units" do
    expect(FactoryGirl.build(:accounts_invoice_item, units:nil)).to be_invalid
  end
  it "is invalid when units is zero" do
    expect(FactoryGirl.build(:accounts_invoice_item, units:0)).to be_invalid
  end
  it "is invalid without unit cost" do
    expect(FactoryGirl.build(:accounts_invoice_item, unit_cost: nil)).to be_invalid
  end
  it "is invalid with negative unit cost" do
    expect(FactoryGirl.build(:accounts_invoice_item, unit_cost: -20)).to be_invalid
  end
  it "returns description units and unit cost per item" do
    item = FactoryGirl.create(:accounts_invoice_item, description: 'item1', units: 1, unit_cost: 2)
    expect(item.to_s).to match "item1 1 2"
  end
end
