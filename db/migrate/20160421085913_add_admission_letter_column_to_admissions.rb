class AddAdmissionLetterColumnToAdmissions < ActiveRecord::Migration
  def change
    add_attachment :admissions, :admission_letter
  end
end
