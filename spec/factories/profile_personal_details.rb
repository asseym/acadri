require 'faker'

FactoryGirl.define do
  factory :profile_personal_detail do
    association :profile, :factory => :profile
    first_name { Faker::Name.first_name }
    other_names { Faker::Name.last_name }
    religion { Faker::Lorem.word }
    sex { 'Female' }
    marital_status { 'Married' }
    birthday { Faker::Date.birthday(min_age=26) }
    nationality { Faker::Lorem.word }
    languages { Faker::Lorem.words(num=2) }
    
  end

end
