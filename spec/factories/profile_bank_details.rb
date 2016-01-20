require 'faker'

FactoryGirl.define do
  factory :profile_bank_detail do |f|
    f.association :user, :factory => :user
    f.bank_details { Faker::Lorem.words(num=5) }
    
  end

end
