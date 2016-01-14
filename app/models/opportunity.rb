class Opportunity < ActiveRecord::Base
  belongs_to :user
  belongs_to :opportunity_status
  has_attached_file :attachment, 
  {
    #url: "/system/:hash.:extension",
    hash_secret: "longSecretString"
  }
  do_not_validate_attachment_file_type :attachment
  
  HUMANIZED_COLUMNS = {:user => "Sales Person", :created_at => "Date Created", :updated_at => "Last Updated"}

  def self.human_attribute_name(attribute)
    HUMANIZED_COLUMNS[attribute.to_sym] || super
  end
  
end
