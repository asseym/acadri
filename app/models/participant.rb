class Participant < ActiveRecord::Base
  has_many :participations
  has_many :trainings, through: :participations
  belongs_to :organisation

  accepts_nested_attributes_for :participations
  accepts_nested_attributes_for :trainings

  GENDER_TYPES = ["Male", "Female"]

  validates_presence_of :name, :sex, :organisation, :job_title
  validates :sex, inclusion: GENDER_TYPES

  def to_s
    "#{name.titleize} #{other_names.titleize}"
  end
end
