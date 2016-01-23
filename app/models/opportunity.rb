class Opportunity < ActiveRecord::Base
  belongs_to :user
  belongs_to :opportunity_status
  has_attached_file :attachment, { hash_secret: "longSecretString" }
  do_not_validate_attachment_file_type :attachment

  validates_presence_of :title, :description, :opportunity_status, :user
  
  HUMANIZED_COLUMNS = {:user => "Sales Person", :created_at => "Date Created", :updated_at => "Last Updated"}

  def self.human_attribute_name(attribute)
    HUMANIZED_COLUMNS[attribute.to_sym] || super
  end

  def create_notification
    if self.opportunity_status.name == "New"
      n = Notification.create!(notification:'New Opportunity Created')
      notifiable_roles = Settings.opportunity_notify
      for usr in User.all
        user_roles = usr.role_symbols
        if (notifiable_roles - user_roles).count <  notifiable_roles.count
          UserNotification.create(notification: n, user: usr)
        end
      end
    end
  end

  def update_notification
    if self.opportunity_status.name == "Won"
      n = Notification.create!(notification:"#{self.id}")
      notifiable_roles = Settings.opportunity_notify
      for usr in User.all
        user_roles = usr.role_symbols
        if (notifiable_roles - user_roles).count <  notifiable_roles.count
          UserNotification.create(notification: n, user: usr)
        end
      end
    end
  end

  def to_s
    title
  end
  
end
