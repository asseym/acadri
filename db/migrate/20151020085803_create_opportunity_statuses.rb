class CreateOpportunityStatuses < ActiveRecord::Migration
  def change
    create_table :opportunity_statuses do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
