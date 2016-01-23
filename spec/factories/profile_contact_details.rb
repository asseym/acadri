require 'faker'

FactoryGirl.define do
  factory :profile_contact_detail do
    association :profile, :factory => :profile
    address { Faker::Address.street_address }
    email_address { Faker::Internet.email }
    business_phone { Faker::PhoneNumber.phone_number }
    mobile_phone { Faker::PhoneNumber.cell_phone }
    home_phone { Faker::PhoneNumber.phone_number }
    fax { Faker::PhoneNumber.phone_number }
    
  end

end
