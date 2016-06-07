module AdmissionsHelper
  def send_admission_button(admission)
    btn = admission.admissions_sent ? 'Resend' : 'Send'
    send_button = "<button class='btn btn-primary' type='button'>#{btn}</button>"
    send_button.html_safe
  end

end
