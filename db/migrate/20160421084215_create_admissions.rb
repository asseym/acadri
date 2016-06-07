class CreateAdmissions < ActiveRecord::Migration
  def change
    create_table :admissions do |t|
      t.references :training, index: true, foreign_key: true
      t.boolean :admissions_sent, default: false

      t.timestamps null: false
    end
  end
end
