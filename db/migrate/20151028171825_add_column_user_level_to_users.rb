class AddColumnUserLevelToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :user_level, index: true, foreign_key: true
  end
end
