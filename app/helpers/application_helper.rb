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
  def inline_title(ttl, minor_title = '')
    if ttl
      if minor_title.empty?
        return { major: ttl.to_s.titleize, minor: '' }
      else
        return { major: ttl.to_s.titleize, minor: minor_title }
      end
    else
      return { major: 'Page Title', minor: 'sample description' }
    end 
  end

  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} alert-dismissible", role: 'alert') do
               concat(content_tag(:button, class: 'close', data: { dismiss: 'alert' }) do
                        concat content_tag(:span, '&times;'.html_safe, 'aria-hidden' => true)
                        concat content_tag(:span, 'Close', class: 'sr-only')
                      end)
               concat message
             end)
    end
    nil
  end

  def number_of_notifications(current_user)
    UserNotification.where(user_id: current_user.id, resolved: false).count
  end

  def notifications_header(num)
    "<h3><span class='bold'>#{num} pending</span> notifications</h3>".html_safe
  end

  def latest_notifcations(current_user)
    notifications_list = ""
    UserNotification.where(user_id: current_user.id).limit(5).order('created_at DESC').each do |notification|
      notifications_list +="<li>#{notification_text(notification)}</li>"
    end
    return notifications_list.html_safe
  end

  def number_of_messages(current_user)
    4
  end

  def messages_header(num)
    "<h3>You have <span class='bold'> #{num} New </span> Messages</h3>".html_safe
  end

  def latest_messages(current_user)
    messages_list = ""
    for i in 0..3
      img_tag = image_tag("avatar3.jpg", class: "img-circle")
      messages_list += %{<li>
            <a href="#">
              <span class="photo">#{img_tag}</span>
              <span class="subject">
                <span class="from">Richard Doe </span>
								<span class="time">16 mins </span>
              </span>
							<span class="message">Vivamus sed congue nibh auctor nibh congue nibh. auctor nibh auctor nibh... </span>
            </a>
						</li>}
    end
    return messages_list.html_safe
  end

  def number_of_calendar_events(current_user)
    4
  end

  def calendar_header(num)
    "<h3>You have <span class='bold'>#{num} pending</span> tasks</h3>".html_safe
  end

  def latest_calendar_events(current_user)
    calendar_list = ""
    for i in 0..3
      calendar_list += "<li>#{calendar_text('UNDP proposal, due: 2/3/2016')}</li>"
    end
    return calendar_list.html_safe
  end

  def calendar_text(cal_text)
    txt = cal_text
    # t = human_readable_time_diff(notification.created_at, Time.now)
    icon = random_icon
    # if txt.to_i > 0
    #   link_to opportunity_path(Opportunity.find(txt.to_i)) do
    #     raw "<span class=\"time\"> #{t}
    #         </span>
    # 		<span class=\"details\">
    # 		<span class=\"label label-sm label-icon label-success\">
    # 		<i class=\"fa #{icon}\"></i>
    # 		</span>
    # 		New invoice pending... </span>"
    #   end
    # else
      lnk = "<a href=\"javascript:;\">
    		<span class=\"time\">
            </span>
    		<span class=\"details\">
    		<span class=\"label label-sm label-icon label-success\">
    		<i class=\"fa #{icon}\"></i>
    		</span>
    		#{txt} </span>
        </a>"
      return raw lnk
    # end
  end

  def menu_hash
    Settings.system_menu
  end

  def build_menu(current_user, menu_hash, is_sub=false)
    menu_li_string = ''
    link_name = ''
    menu_hash.each do |name, menu|
      can_access = menu_accessible?(current_user, menu)
      if can_access
        menu_li_string += '<li>'
        if menu[:path]
          menu_li_string += link_to menu[:path] do
            if menu[:icon]
              link_name +="<i class='#{menu[:icon]}'></i>"
            end
            if is_sub
              link_name +="<span class='title'> + #{name.to_s.underscore.humanize.titleize}</span>"
            else
              link_name +="<span class='title'>#{name.to_s.underscore.humanize.titleize}</span>"
            end
            unless is_sub == true
              link_name +='<span class="arrow"></span>'
            end
            link_name.html_safe
          end
          link_name = ''
        else
          menu_li_string += '<a href="javascript:;">'
          if menu[:icon]
            menu_li_string +="<i class='#{menu[:icon]}'></i>"
          end
          menu_li_string +="<span class='title'>#{name.to_s.underscore.humanize.titleize}</span>"
          menu_li_string +='<span class="arrow"></span>'
          if has_sub_menu?(menu)
            menu_li_string += '<ul class="sub-menu">'
            menu_li_string += build_menu current_user, menu[:submenus], true
            menu_li_string += '</ul>'
          end
        end
        menu_li_string +='</li>'
      end
    end
    return menu_li_string.html_safe
  end

  def menu_accessible?(current_user, menu)
    if !menu[:accessible].blank?
      if menu[:accessible] == :all
        return true
      else
        user_roles = current_user.role_symbols
        if (menu[:accessible] - user_roles).count <  menu[:accessible].count
          return true
        end
      end
    else
      return true
    end
  end

  def has_sub_menu?(menu)
    if !menu[:submenus].blank?
      return true
    end
  end

  def can_see_general_dashboard(user)
    roles = Settings.can_see_general_dashboard
    return true if (roles - user.role_symbols).count < roles.count
  end

end
