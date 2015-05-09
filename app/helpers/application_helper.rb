module ApplicationHelper
  #Return a full title on a per page basis
  def full_title(page_title = '')
    base_title = "S!mple.ERP"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end
  
  #Return major inline page title and description of page
  def inline_title(page_controller, minor_title = '')
    if page_controller
      if minor_title.empty?
        return { major: page_controller.titleize, minor: '' }
      else
        return { major: page_controller.titleize, minor: minor_title }
      end
    else
      return { major: 'Page Title', minor: 'sample description' }
    end 
  end
end
