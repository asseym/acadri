require 'faker'

FactoryGirl.define do
  factory :accounts_invoice do
    association :training, :factory => :training
    invoice_date { Faker::Date.forward(days=1) }
    invoice_terms {Faker::Lorem.sentence }
    currency {'USD'}
    factory :accounts_invoice_with_items do
      after(:create) do |accounts_invoice|
        FactoryGirl.create(:accounts_invoice_item, accounts_invoice: accounts_invoice)
      end
    end
  end
end