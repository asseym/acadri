class CreateRfqs < ActiveRecord::Migration
  def change
    create_table :rfqs do |t|
      t.string :rfq_id
      t.string :action
      t.date :rfq_date
      t.date :due_date
      t.text :issuer
      t.text :description

      t.timestamps null: false
    end
  end
end
