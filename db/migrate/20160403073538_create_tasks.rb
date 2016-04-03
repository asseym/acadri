class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :status, default: 'New'
      t.string :title
      t.string :task_type
      t.date :start_date
      t.date :end_date
      t.string :description

      t.timestamps null: false
    end
  end
end
