require 'faker'

FactoryGirl.define do
  factory :category do |f|
    f.name { Faker::Lorem.word }
  end

end
