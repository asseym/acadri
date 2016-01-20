require 'faker'

include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :profile_general_detail do |f|
    f.association :user, :factory => :user
    f.title { Faker::Name.title }
    f.education { Faker::Lorem.words(num=10) }
    f.staff_id { Faker::Code.ean }
    f.date_hired { Faker::Date.backward(days=567) }
    f.passport_number { Faker::Code.ean }
    f.drivers_licence { Faker::Code.ean }
    f.salary { Faker::Number.number(6) }
    f.NSSF_number { Faker::Code.ean }
    f.cv { fixture_file_upload(Rails.root.join('spec', 'attachments', 'test.pdf'), 'application/pdf') }
    f.photo { fixture_file_upload(Rails.root.join('spec', 'photos', 'test.png'), 'image/png') }
    
  end

end
