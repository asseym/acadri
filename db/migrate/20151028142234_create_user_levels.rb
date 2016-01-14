class CreateUserLevels < ActiveRecord::Migration
  def change
    create_table :user_levels do |t|
      t.belongs_to :user, index: true
      t.string :name

      t.timestamps null: false
    end
  end
end
