class ProfilePersonalDetail < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :nationality, :sex, :first_name, :other_names

  def age
    today = Date.today
    this_yr_bod = Date.new(today.year, birthday.month, birthday.day)
    this_yr_bod.year - birthday.year - (this_yr_bod > today ? 1 : 0)
  end
end
