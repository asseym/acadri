require 'faker'

FactoryGirl.define do
  factory :opportunity_status do
    name { Faker::Lorem.word }

    trait :new do
      name { 'New' }
    end

    trait :won do
      name { 'Won' }
    end

    factory :opportunity_status_new, traits: [:new]
    factory :opportunity_status_won, traits: [:won]
  end
end
