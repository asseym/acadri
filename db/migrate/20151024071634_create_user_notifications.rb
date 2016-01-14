class CreateUserNotifications < ActiveRecord::Migration
  def change
    create_table :user_notifications do |t|
      t.references :notification, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.boolean :resolved, default: false

      t.timestamps null: false
    end
  end
end
