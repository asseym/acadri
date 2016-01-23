require 'faker'

FactoryGirl.define do
  factory :organisation do
    name { Faker::Lorem.word }
    address { Faker::Address.street_address }
    postal_address { Faker::Address.postcode }
    association :country, :factory => :country
    telephones { Faker::PhoneNumber.phone_number }
    email_address { Faker::Internet.email('Info') }
    website { Faker::Internet.url('example.com') }
    
  end

end
