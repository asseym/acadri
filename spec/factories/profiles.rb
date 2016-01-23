require 'faker'

FactoryGirl.define do
  factory :profile do
    association :user, :factory => :user
    section_name { Faker::Lorem.words(num=2) }

    transient do
      profile_count 3
    end

    trait :personal_section do
      section_name "Personal Details"
    end

    trait :contact_section do
      section_name "Contact Details"
    end

    trait :bank_section do
      section_name "Bank Details"
    end

    trait :general_section do
      section_name "General Details"
    end

    factory :profile_with_personal_details do
      personal_section
      after(:create) do |profile|
        FactoryGirl.create(:profile_personal_detail, profile: profile)
      end
    end

    factory :profile_with_general_details do
      general_section
      after(:create) do |profile|
        FactoryGirl.create(:profile_general_detail, profile: profile)
      end
    end

    factory :profile_with_bank_details do
      bank_section
      after(:create) do |profile|
        FactoryGirl.create(:profile_bank_detail, profile: profile)
      end
    end

    factory :profile_with_contact_details do
      contact_section
      after(:create) do |profile|
        FactoryGirl.create(:profile_contact_detail, profile: profile)
      end
    end
    
  end

end
