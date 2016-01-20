require 'faker'

FactoryGirl.define do
  factory :notification do |f|
    f.notification { Faker::Lorem.sentence(word_count=5)}
    
  end

end
