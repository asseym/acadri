class AddTitleToProfileGeneralDetail < ActiveRecord::Migration
  def change
    add_column :profile_general_details, :title, :string
  end
end
