class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable

  include RoleModel

  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :password_confirmation, :remember_me, :roles, :roles_mask

  # optionally set the integer attribute to store the roles in,
  # :roles_mask is the default
  roles_attribute :roles_mask

  # declare the valid roles -- do not change the order if you add more
  # roles later, always append them at the end!
  roles :admin, :ceo, :finance, :program_coordinator, :manager, :marketing, :guest, :staff

  has_many :user_notifications
  has_many :notifications, through: :user_notifications
  has_one :profile_personal_detail, autosave: true
  has_one :profile_general_detail, autosave: true
  has_one :profile_contact_detail, autosave: true
  has_one :profile_bank_detail, autosave: true
         
  accepts_nested_attributes_for :profile_personal_detail, :allow_destroy => true
  accepts_nested_attributes_for :profile_general_detail, :allow_destroy => true
  accepts_nested_attributes_for :profile_contact_detail, :allow_destroy => true
  accepts_nested_attributes_for :profile_bank_detail, :allow_destroy => true

        
  GENDER_TYPES = [:Male, :Female]
  MARITAL_STATUS = [:Single, :Married, :Complicated]

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
