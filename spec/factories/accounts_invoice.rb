require 'faker'

FactoryGirl.define do
  factory :accounts_invoice do |f|
    f.association :training, :factory => :training
    f.invoice_date { Faker::Date.forward(days=1) }
    f.invoice_terms {Faker::Lorem.sentence }
    f.currency {'USD'}
    factory :accounts_invoice_with_items do
      after(:create) do |accounts_invoice|
        FactoryGirl.create(:accounts_invoice_item, accounts_invoice: accounts_invoice)
      end
    end
  end
end