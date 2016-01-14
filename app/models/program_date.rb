class ProgramDate < ActiveRecord::Base
  belongs_to :program, foreign_key: "program_id"
end
