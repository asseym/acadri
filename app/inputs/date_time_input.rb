class DateTimeInput < SimpleForm::Inputs::DateTimeInput
  def input(wrapper_options)
    content = super
    template.content_tag(:div, content, class: 'col-sm-9')
  end
end