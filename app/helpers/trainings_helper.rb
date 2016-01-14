module TrainingsHelper
  def training_title(training)
    if training.title
      return training.title
    else
      return training.program.name
    end
  end
end
