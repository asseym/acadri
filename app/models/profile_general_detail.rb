class ProfileGeneralDetail < ActiveRecord::Base
  belongs_to :user

  has_attached_file :cv, {
      #url: "/system/:hash.:extension",
      hash_secret: "longSecretString"
  }
  do_not_validate_attachment_file_type :cv

  has_attached_file :photo, {
                           #url: "/system/:hash.:extension",
                           hash_secret: "longSecretString"
                       }
  do_not_validate_attachment_file_type :photo

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
