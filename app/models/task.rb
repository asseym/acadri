class Task < ActiveRecord::Base
  has_many :assignments
  has_many :users, through: :assignments

  validates_presence_of :title, :task_type, :status
  accepts_nested_attributes_for :assignments
  accepts_nested_attributes_for :users

  TASK_TYPE = ['Response to RFQ/RFP', 'Conference Facilitation', 'Sales Calls']
  TASK_STATUS = ['New', 'In Progress', 'On Hold', 'Finished', 'Dropped']
  TASK_STATUS_COLOR_CODES = ['primary', 'info', 'warning', 'success', 'danger']

  def self.pending(user)
    status = ['Finished', 'Dropped']
    self.joins(:assignments).where.not(status: status).where("assignments.user_id = ?",user.id)
  end
end
