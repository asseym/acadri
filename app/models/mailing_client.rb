class MailingClient < ActiveRecord::Base

  def self.active
    return self.where(active: true)
  end
end
