class User < ActiveRecord::Base
  
  #attr_reader :current_user
  
  has_many :user_notifications
  has_many :notifications, through: :user_notifications
  has_one :user_level
  has_one :profile_personal_detail, autosave: true
  has_one :profile_general_detail, autosave: true
  has_one :profile_contact_detail, autosave: true
  has_one :profile_bank_detail, autosave: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable
         
  accepts_nested_attributes_for :profile_personal_detail, :allow_destroy => true
  accepts_nested_attributes_for :profile_general_detail, :allow_destroy => true
  accepts_nested_attributes_for :profile_contact_detail, :allow_destroy => true
  accepts_nested_attributes_for :profile_bank_detail, :allow_destroy => true

        
  GENDER_TYPES = [:Male, :Female]
  MARITAL_STATUS = [:Single, :Married, :Complicated]
=begin   
  HUMANIZED_COLUMNS = {
    :user_level_id => "Department",
    :admin => "Administrator",
    :is_staff => "Staff Member"
  }
    def self.human_attribute_name(attribute)
      HUMANIZED_COLUMNS[attribute.to_sym] || super
    end
  
=end
  class << self
    def current_user=(user)
      Thread.current[:current_user] = user
    end

    def current_user
      Thread.current[:current_user]
    end
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
