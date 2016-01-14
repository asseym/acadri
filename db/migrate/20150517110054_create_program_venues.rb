class CreateProgramVenues < ActiveRecord::Migration
  def change
    create_table :program_venues do |t|
      t.string :name
      t.references :country, index: true, foreign_key: true
      t.belongs_to :program, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
