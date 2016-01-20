require 'faker'

FactoryGirl.define do
  factory :profile do |f|
    f.section_name { Faker::Lorem.words(num=2) }
    
  end

end
