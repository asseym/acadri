class ProfileContactDetail < ActiveRecord::Base
  belongs_to :profile

  validates_presence_of :profile, :address, :email_address, :mobile_phone
  validates :email_address, email: true
end
