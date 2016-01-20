require 'faker'

FactoryGirl.define do
  factory :profile_personal_detail do |f|
    f.association :user, :factory => :user
    f.first_name { Faker::Name.first_name }
    f.other_names { Faker::Name.last_name }
    f.religion { Faker::Lorem.word }
    f.sex { 'Female' }
    f.marital_status { 'Married' }
    f.birthday { Faker::Date.birthday(min_age=26) }
    f.nationality { Faker::Lorem.word }
    f.languages { Faker::Lorem.words(num=2) }
    
  end

end
