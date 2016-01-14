class CreateTrainings < ActiveRecord::Migration
  def change
    create_table :trainings do |t|
      t.string :title
      t.references :program, index: true, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.integer :fees
      t.integer :fees_paid
      t.integer :fees_balance
      t.references :program_venue, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
