class Training < ActiveRecord::Base
  has_many :participations
  has_many :participants, through: :participations
  belongs_to :program
  belongs_to :program_venue
end
