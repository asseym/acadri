class ProfileBankDetail < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :bank_details

  def to_s
    bank_details
  end
end
