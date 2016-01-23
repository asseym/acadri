require 'faker'

FactoryGirl.define do
  factory :training do
    title { Faker::Lorem.sentence }
    association :program, :factory => :program
    start_date { Faker::Date.forward(days=14) }
    end_date { Faker::Date.forward(days=35) }
    fees { 2500 }
    fees_paid { 0 }
    fees_balance { 2500 }
    association :program_venue, :factory => :program_venue

    transient do
      participant_count 5
    end

    factory :training_with_participants do
      after(:create) do |training, evaluator|
        training.participations << FactoryGirl.create_list(:participation, evaluator.participant_count,
                                                         participant: FactoryGirl.create(:participant))
      end
    end
  end

end
