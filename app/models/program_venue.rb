class ProgramVenue < ActiveRecord::Base
  belongs_to :country
  belongs_to :program, foreign_key: "program_id"
  validates_presence_of :name, :country

  def to_s
    {'place': name, 'country': country.name }
  end
end
