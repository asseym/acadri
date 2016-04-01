FactoryGirl.define do
  factory :expense do
    item "MyString"
description "MyText"
expense_date "2016-04-01"
qty 1
unit_price 1
tax 1
invoice_ref "MyString"
  end

end
