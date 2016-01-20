require 'faker'

FactoryGirl.define do
  factory :opportunity_status do |f|
    f.name { Faker::Lorem.word }
    
  end

end
