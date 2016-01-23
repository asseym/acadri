class Organisation < ActiveRecord::Base
  belongs_to :country
  validates_presence_of :name, :address, :postal_address, :email_address, :telephones, :country
  validates :email_address, email: true

  def to_s
    name
  end
end
