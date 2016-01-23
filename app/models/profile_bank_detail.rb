class ProfileBankDetail < ActiveRecord::Base
  belongs_to :profile

  validates_presence_of :profile, :bank_details

  def to_s
    bank_details
  end
end
