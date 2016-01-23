require 'faker'

FactoryGirl.define do
  factory :user do
    name { Faker::Lorem.word }
    email { Faker::Internet.email(name='Example User') }
    password { Faker::Internet.password }
    confirmation_token { nil }
    confirmed_at { Faker::Date.forward(days=0) }
    roles {['guest']}

    trait :is_guest_user do
      is_staff { false }
    end

    trait :is_staff do
      is_staff { true }
    end

    trait :is_admin do
      admin { true }
    end

    trait :has_admin_role do
      roles {['admin']}
    end

    trait :has_ceo_role do
      roles {['ceo']}
    end

    trait :has_finance_role do
      roles {['finance']}
    end

    trait :has_program_coordinator_role do
      roles {['program_coordinator']}
    end

    trait :has_manager_role do
      roles {['manager']}
    end

    trait :has_marketing_role do
      roles {['marketing']}
    end

    trait :has_personal_details do
      association :profile, :factory => :profile_with_personal_details
    end

    trait :has_contact_details do
      association :profile, :factory => :profile_with_contact_details
    end

    factory :ordinary_user,   traits: [:is_guest_user]
    factory :staff_user,        traits: [:is_staff]
    factory :admin_user,      traits: [:is_staff, :is_admin, :has_admin_role]
    factory :ceo_user,    traits: [:is_staff, :has_ceo_role]
    factory :finance_user,    traits: [:is_staff, :has_finance_role]
    factory :program_coordinator_user,    traits: [:is_staff, :has_program_coordinator_role]
    factory :manager_user,    traits: [:is_staff, :has_manager_role]
    factory :marketing_user,    traits: [:is_staff, :has_marketing_role]

    # factory :ordinary_user_with_profile, traits: [:is_guest_user, :has_personal_details, :has_contact_details]
    # factory :admin_user_with_profile, traits: [:is_staff, :is_admin, :has_admin_role, :has_personal_details, :has_contact_details]

    factory :user_with_profile do
      after(:create) do |user|
        FactoryGirl.create(:profile_with_personal_details, user: user)
        FactoryGirl.create(:profile_with_contact_details, user:user)
      end
    end

  end

end
