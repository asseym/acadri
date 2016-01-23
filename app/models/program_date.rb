class ProgramDate < ActiveRecord::Base
  belongs_to :program, foreign_key: "program_id"
  validates_presence_of :start_date, :end_date

  def to_s
    {'start': start_date, 'end': end_date }
  end
end
