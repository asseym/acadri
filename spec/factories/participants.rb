FactoryGirl.define do
  factory :participant do |f|
    f.name { Faker::Name.first_name }
    f.other_names { Faker::Name.last_name }
    f.sex { 'Male' }
    f.passport_no { Faker::Code.ean }
    f.job_title { Faker::Name.title }
    f.association :organisation, :factory => :organisation
    
  end

end
