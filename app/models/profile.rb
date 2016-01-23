class Profile < ActiveRecord::Base
  belongs_to :user
  has_many :profile_personal_details
  has_many :profile_bank_details
  has_many :profile_general_details
  has_many :profile_contact_details

  accepts_nested_attributes_for :profile_personal_details, :allow_destroy => true
  accepts_nested_attributes_for :profile_general_details, :allow_destroy => true
  accepts_nested_attributes_for :profile_contact_details, :allow_destroy => true
  accepts_nested_attributes_for :profile_bank_details, :allow_destroy => true

  validates_presence_of :section_name, :user

  def personal_details
    profile_personal_details.all
  end

  def general_details
    profile_general_details.all
  end

  def bank_details
    profile_bank_details.all
  end

  def contact_details
    profile_contact_details.all
  end

  protected
     def profile_personal_detail
       super || build_profile_personal_detail
     end

     def profile_general_detail
       super || build_profile_general_detail
     end

     def profile_contact_detail
       super || build_profile_contact_detail
     end

     def profile_bank_detail
       super || build_profile_bank_detail
     end
end
