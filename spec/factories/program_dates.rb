require 'faker'

FactoryGirl.define do
  factory :program_date do |f|
    f.start_date { Faker::Date.forward(days=0)}
    f.end_date { Faker::Date.forward(days=21) }
    
  end

end
