class TrainingObserver < ActiveRecord::Observer
  #if no title provided copy it from program
  def after_create(training)
    training.make_title
    Admission.make_admission(training)
  end
  
end