require 'faker'

FactoryGirl.define do
  factory :accounts_invoice_item do |f|
    f.description { Faker::Lorem.sentence }
    f.units { Faker::Number.non_zero_digit}
    f.unit_cost { Faker::Number.number(4)}
    
  end

end
