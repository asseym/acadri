require 'faker'

FactoryGirl.define do
  factory :profile_bank_detail do
    association :user, :factory => :user
    bank_details { Faker::Lorem.words(num=5) }
    
  end

end
