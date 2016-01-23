class ProfileGeneralDetail < ActiveRecord::Base
  belongs_to :profile

  has_attached_file :cv, { hash_secret: "longSecretString" }
  do_not_validate_attachment_file_type :cv

  has_attached_file :photo, { hash_secret: "longSecretString" }
  do_not_validate_attachment_file_type :photo

  validates_presence_of :profile, :title, :education, :date_hired, :salary
  validates_numericality_of :salary

end
