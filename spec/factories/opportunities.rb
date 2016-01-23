require 'faker'

include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :opportunity do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.sentence }
    association :opportunity_status, :factory => :opportunity_status
    association :user, :factory => :user
    attachment { fixture_file_upload(Rails.root.join('spec', 'attachments', 'test.pdf'), 'application/pdf') }

    factory :opportunity_with_new_status do |opportunity|
      opportunity.opportunity_status :factory => :opportunity_status_new
    end

    factory :opportunity_with_won_status do |opportunity|
      opportunity.opportunity_status :factory => :opportunity_status_won
    end

  end
end
