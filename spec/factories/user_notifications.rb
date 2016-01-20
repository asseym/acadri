FactoryGirl.define do
  factory :user_notification do |f|
    f.association :notification, :factory => :notification
    f.association :user, :factory => :user
    
  end

end
