class CreateProgramDates < ActiveRecord::Migration
  def change
    create_table :program_dates do |t|
      t.date :start_date
      t.date :end_date
      t.belongs_to :program, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
