require 'faker'

FactoryGirl.define do
  factory :organisation do |f|
    f.name { Faker::Lorem.word }
    f.address { Faker::Address.street_address }
    f.postal_address { Faker::Address.postcode }
    f.association :country, :factory => :country
    f.telephones { Faker::PhoneNumber.phone_number }
    f.email_address { Faker::Internet.email('Info') }
    f.website { Faker::Internet.url('example.com') }
    
  end

end
