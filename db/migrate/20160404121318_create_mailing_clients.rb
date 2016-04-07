class CreateMailingClients < ActiveRecord::Migration
  def change
    create_table :mailing_clients do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.boolean :active

      t.timestamps null: false
    end
  end
end
