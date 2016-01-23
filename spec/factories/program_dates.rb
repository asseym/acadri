require 'faker'

FactoryGirl.define do
  factory :program_date do
    start_date { Faker::Date.forward(days=0)}
    end_date { Faker::Date.forward(days=21) }
    
  end

end
