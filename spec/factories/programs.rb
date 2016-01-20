require 'faker'

FactoryGirl.define do
  factory :program do |f|
    f.name { Faker::Lorem.sentence }
    f.association :category, :factory => :category
    f.description { Faker::Lorem.sentence }
    f.is_service { true }
    factory :program_with_dates_and_venues do
      after(:create) do |program|
        FactoryGirl.create(:program_date, program:  program)
        FactoryGirl.create(:program_venue, program:  program)
      end
    end
  end

end
