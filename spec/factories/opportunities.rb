require 'faker'

include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :opportunity do |f|
    f.title { Faker::Lorem.sentence }
    f.description { Faker::Lorem.sentence }
    f.association :opportunity_status, :factory => :opportunity_status
    f.association :user, :factory => :user
    f.attachment { fixture_file_upload(Rails.root.join('spec', 'attachments', 'test.pdf'), 'application/pdf') }
    
  end

end
