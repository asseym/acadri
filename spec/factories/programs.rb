require 'faker'

FactoryGirl.define do
  factory :program do
    name { Faker::Lorem.sentence }
    association :category, :factory => :category
    description { Faker::Lorem.sentence }
    is_service { true }
    factory :program_with_dates_and_venues do
      after(:create) do |program|
        FactoryGirl.create(:program_date, program:  program)
        FactoryGirl.create(:program_venue, program:  program)
      end
    end
  end

end
