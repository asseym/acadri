class CreateOrganisations < ActiveRecord::Migration
  def change
    create_table :organisations do |t|
      t.string :name
      t.text :address
      t.string :postal_address
      t.references :country, index: true, foreign_key: true
      t.text :telephones
      t.text :email_address
      t.text :website

      t.timestamps null: false
    end
  end
end
