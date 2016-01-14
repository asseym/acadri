class RenameColumnProductToIsService < ActiveRecord::Migration
  def change
    rename_column :products, :product, :is_service
  end
end
