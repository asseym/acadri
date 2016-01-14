class ProfileGeneralDetail < ActiveRecord::Base
  belongs_to :user

=begin  
  HUMANIZED_COLUMNS = {
    :staff_id => "Staff ID Number",
    :cv => "Employee CV",
    :photo => "Employee Portrait" 
  }

  def self.human_attribute_name(attribute)
    HUMANIZED_COLUMNS[attribute.to_sym] || super
  end
=end

end
