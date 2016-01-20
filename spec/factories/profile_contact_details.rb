require 'faker'

FactoryGirl.define do
  factory :profile_contact_detail do |f|
    f.association :user, :factory => :user
    f.address { Faker::Address.street_address }
    f.email_address { Faker::Internet.email }
    f.business_phone { Faker::PhoneNumber.phone_number }
    f.mobile_phone { Faker::PhoneNumber.cell_phone }
    f.home_phone { Faker::PhoneNumber.phone_number }
    f.fax { Faker::PhoneNumber.phone_number }
    
  end

end
