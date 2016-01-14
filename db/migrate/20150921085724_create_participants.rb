class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.string :name
      t.string :other_names
      t.string :sex
      t.string :passport_no
      t.string :job_title
      t.references :organisation, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
