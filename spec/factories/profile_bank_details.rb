require 'faker'

FactoryGirl.define do
  factory :profile_bank_detail do
    association :profile, :factory => :profile
    bank_details { Faker::Lorem.words(num=5) }
    
  end

end
