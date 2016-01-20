require 'faker'

FactoryGirl.define do
  factory :training do |f|
    f.title { Faker::Lorem.sentence }
    f.association :program, :factory => :program
    f.start_date { Faker::Date.forward(days=14) }
    f.end_date { Faker::Date.forward(days=35) }
    f.fees { 2500 }
    f.fees_paid { 0 }
    f.fees_balance { 2500 }
    f.association :program_venue, :factory => :program_venue
    factory :training_with_participants do
      after(:create) do |training|
        FactoryGirl.create(:participant, training: training)
      end
    end
  end

end
