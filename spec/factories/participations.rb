FactoryGirl.define do
  factory :participation do |f|
    f.association :training, :factory => :training
    f.association :participant, :factory => :participant
    
  end

end
