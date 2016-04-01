class Training < ActiveRecord::Base
  has_many :participations
  has_many :participants, through: :participations
  belongs_to :program
  belongs_to :program_venue

  accepts_nested_attributes_for :participations
  accepts_nested_attributes_for :participants

  validates_presence_of :program, :start_date, :end_date, :fees, :program_venue

  def to_s
    title
  end

  def make_title
    if self.title.blank?
      self.title = self.program.name
      self.save
    end
  end
end
