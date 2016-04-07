class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable

  include RoleModel
  roles_attribute :roles_mask

  # declare the valid roles -- do not change the order if you add more
  # roles later, always append them at the end!
  roles :admin, :ceo, :finance, :program_coordinator, :manager, :marketing, :guest, :staff, :superadmin

  has_many :user_notifications
  has_many :notifications, through: :user_notifications
  has_many :assignments
  has_many :tasks, through: :assignments
  has_one :profile_personal_detail
  has_one :profile_general_detail
  has_one :profile_contact_detail
  has_one :profile_bank_detail
  accepts_nested_attributes_for :profile_personal_detail, :allow_destroy => true
  accepts_nested_attributes_for :profile_general_detail, :allow_destroy => true
  accepts_nested_attributes_for :profile_contact_detail, :allow_destroy => true
  accepts_nested_attributes_for :profile_bank_detail, :allow_destroy => true
  accepts_nested_attributes_for :assignments
  accepts_nested_attributes_for :tasks

  validates_presence_of :email, :roles
  validates :password,  :presence     => true,
                        :confirmation => true,
                        :length       => { :minimum => 6 },
                        :if           => :password # only validate if password changed!
  validates :email, email: true
  # accepts_nested_attributes_for :profiles, reject_if: :all_blank, allow_destroy: true
        
  GENDER_TYPES = [:Male, :Female]
  MARITAL_STATUS = [:Single, :Married, :Complicated]
  ROLES = [:admin, :ceo, :finance, :program_coordinator, :manager, :marketing, :guest, :staff, :superadmin]

  #mailboxer
  acts_as_messageable

  def create_notification
    notifiable_roles = Settings.user_creation_notify
    for usr in User.all
      user_roles = usr.role_symbols
      if (notifiable_roles - user_roles).count <  notifiable_roles.count
        usr.notifications.create(notification: Notification.create!(notification: "New User #{self.name} Created"))
      end
    end
  end

  def notify(notification)
    self.notifications.create(notification: Notification.create!(notification:notification.to_s))
  end

  def personal_details
    self.profile_personal_detail
  end

  def contact_details
    self.profile_contact_detail
  end

  def bank_details
    self.profile_bank_detail
  end

  def general_details
    self.profile_general_detail
  end

  SEARCH_FIELDS = ["profile_personal_details.first_name", "profile_personal_details.other_names", :email]

  def self.like(query)
    joined = self.joins(:profile_personal_detail)
    SEARCH_FIELDS.each_with_index { |field, index|
      if joined.where("#{field.to_s} LIKE ?","%#{query}%").count > 0 then
        return joined.where("#{field.to_s} LIKE ?", "%#{query}%")
        break
      elsif index == SEARCH_FIELDS.size - 1
        return where(1)
      end
    }
  end

  def to_s
    if personal_details
      return "#{personal_details.first_name} #{self.personal_details.other_names}"
    else
      return self.name
    end
  end

  def name=(name)
    write_attribute(:name, to_s)
  end

  def name
    # read_attribute(:name).downcase  # No test for nil?
    self.name = to_s
  end

  def mailboxer_email(object)
    self.email
  end

end
