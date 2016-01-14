class ProgramVenue < ActiveRecord::Base
  belongs_to :country
  belongs_to :program, foreign_key: "program_id"
end
