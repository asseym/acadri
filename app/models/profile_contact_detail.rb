class ProfileContactDetail < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :address, :mobile_phone
  # validates :email_address, email: true
end
