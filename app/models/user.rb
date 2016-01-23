class User < ActiveRecord::Base

  # alias_attribute :profile_details, :profiles

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable

  include RoleModel
  roles_attribute :roles_mask

  # declare the valid roles -- do not change the order if you add more
  # roles later, always append them at the end!
  roles :admin, :ceo, :finance, :program_coordinator, :manager, :marketing, :guest, :staff

  has_many :user_notifications
  has_many :notifications, through: :user_notifications
  has_many :profiles

  validates_presence_of :name, :email, :password, :roles
  validates :email, email: true

        
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

  def create_notification
    n = Notification.create!(notification:'New User #{self.name} Created')
    notifiable_roles = Settings.user_creation_notify
    for usr in User.all
      user_roles = usr.role_symbols
      if (notifiable_roles - user_roles).count <  notifiable_roles.count
        UserNotification.create(notification: n, user: usr)
      end
    end
  end

  def personal_details
    profiles.all.find_by(section_name: 'Personal Details').profile_personal_details.first
  end

  def contact_details
    profiles.all.find_by(section_name: 'Contact Details').profile_contact_details.first
  end

  def bank_details
    profiles.all.find_by(section_name: 'Bank Details').profile_bank_details.first
  end

  def general_details
    profiles.all.find_by(section_name: 'General Details').profile_general_details.first
  end

end
