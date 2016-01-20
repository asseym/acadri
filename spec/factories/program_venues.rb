require 'faker'

FactoryGirl.define do
  factory :program_venue do |f|
    f.name { 'Kampala' }
    f.association :country, :factory => :country
  end

end
