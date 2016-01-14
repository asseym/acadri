class TrainingObserver < ActiveRecord::Observer
  
  #Every if no title provided copy it from program
  def after_create(training)
    if training.title.blank?
      training.title = training.program.name
      training.save()
    end
  end
  
end