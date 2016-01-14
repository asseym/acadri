class Participant < ActiveRecord::Base
  has_many :participations
  has_many :trainings, through: :participations
  belongs_to :organisation
  belongs_to :training, foreign_key: "training_id"
  
  GENDER_TYPES = [ "Male", "Female"]

  validates :sex, inclusion: GENDER_TYPES
end
