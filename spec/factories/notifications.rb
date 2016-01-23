require 'faker'

FactoryGirl.define do
  factory :notification do |f|
    f.notification { Faker::Lorem.sentence(word_count=5)}

    factory :notification_with_users do
      after(:create) do |notification|
        notification.user_notifications << FactoryGirl.create(:user_notification, user: FactoryGirl.create(:user))
      end
    end
    
  end

end
