class Participation < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.belongs_to :training
      t.belongs_to :participant

      t.timestamps null: false
    end
  end
end
