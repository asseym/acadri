require 'faker'

include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :profile_general_detail do
    association :user, :factory => :user
    title { Faker::Name.title }
    education { Faker::Lorem.words(num=10) }
    staff_id { Faker::Code.ean }
    date_hired { Faker::Date.backward(days=567) }
    passport_number { Faker::Code.ean }
    drivers_licence { Faker::Code.ean }
    salary { Faker::Number.number(6) }
    NSSF_number { Faker::Code.ean }
    cv { fixture_file_upload(Rails.root.join('spec', 'attachments', 'test.pdf'), 'application/pdf') }
    photo { fixture_file_upload(Rails.root.join('spec', 'photos', 'test.png'), 'image/png') }
    
  end

end
