class Participant < ActiveRecord::Base
  has_many :participations
  has_many :trainings, through: :participations
  belongs_to :organisation
  belongs_to :training, foreign_key: "training_id"
  
  GENDER_TYPES = [ "Male", "Female"]

  validates_presence_of :name, :sex, :organisation, :job_title
  validates :sex, inclusion: GENDER_TYPES

  def to_s
    "#{name.titleize} #{other_names.titleize}"
  end
end
