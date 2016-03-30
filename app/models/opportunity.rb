class Opportunity < ActiveRecord::Base
  belongs_to :user
  belongs_to :opportunity_status
  has_attached_file :attachment, { url: "/system/:hash.:extension", hash_secret: "acadriInternalEnt3rpriseResourcePlanning2015"}
  validates_attachment :attachment,
                       content_type: { :content_type => %w(application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document) },
                       size: { in: 0..1500.kilobytes }

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

  def status
    self.opportunity_status
  end

  def created
    self.created_at.to_formatted_s(:long)
  end

  def last_updated
    self.updated_at.to_formatted_s(:long)
  end

  def sales_person
    self.user.name
  end

  def to_s
    title
  end
  
end
