class Participation < ActiveRecord::Base
  belongs_to :training
  belongs_to :participant
end
