require 'faker'

FactoryGirl.define do
  factory :country do |f|
    f.name { 'Uganda' }
    f.c_code { 'UG' }
    f.telephone_code { 256 }
    
  end

end
