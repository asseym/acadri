class AddColumnIsStaffToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_staff, :boolean, default: true
  end
end
