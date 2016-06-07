class Admission < ActiveRecord::Base
  belongs_to :training
  has_attached_file :admission_letter,
                    :url => "/admissions/get/:id",
                    :path => "/public/admission_letters/:id/:basename.:extension"
  validates_format_of :admission_letter_file_name, :with => %r{\.(docx|doc|pdf)\z}i,
                      :message => "Can only upload MS WORD or PDF files.",
                      :allow_blank => true
  validates_presence_of :training

  def to_s
    self.training.title
  end

  def self.make_admission(training)
    Admission.create(training: training)
  end

  def create_training_successful(training)
    Admission.create(training_id: training.id)
  end
end
