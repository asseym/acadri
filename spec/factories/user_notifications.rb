FactoryGirl.define do
  factory :user_notification do
    association :notification, :factory => :notification
    association :user, :factory => :user
    resolved  { false }
    
  end

end
