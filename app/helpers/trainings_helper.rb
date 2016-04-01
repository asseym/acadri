module TrainingsHelper
  def training_title(training)
    if training.title
      return training.title
    else
      return training.program.name
    end
  end

  def training_venue(training)
    if training.program_venue
      "#{training.program_venue.name}, #{training.program_venue.country}"
    end
  end

  def list_participants(training)
    lst = '<ul>'
    unless training.participants.empty?
      training.participants.each do |pt|
        lst += "<li>#{pt.name} #{pt.other_names} (#{pt.organisation})</li>"
      end
    end
    lst += '</ul>'
    lst.html_safe
  end

  def fees_paid(training)
    training.fees_paid ? training.fees_paid : 0
  end

  def fees_balance(training)
    bal = training.fees_paid ? training.fees - training.fees_paid : training.fees
    bal > 0 ? "<span class='label label-danger'>#{bal}</span>".html_safe : 0


  end
end
