module NotificationsHelper
  
  #time difference short and long
  
  def human_readable_time_diff(start_time, end_time, short=true)
    fms = {
      years: "yrs", 
      months: "months", 
      weeks: "wks",
      days: "days",
      hours: "hrs", 
      minutes: "mins", 
      seconds: "secs"
    }
    t_comps = TimeDifference.between(start_time, end_time).in_general
    t_comps.delete_if {|k,v| v == 0 }
    t_comps.delete_if {|k,v| v.nil? }
    comp, t = t_comps.first
    comp = short ? fms[comp] : comp
    "#{t} #{comp}"
  end
  
  def random_icon
    ["fa-bullhorn", "fa fa-bolt", "fa-bell-o", "fa-bolt", "fa-plus"].sample
  end
  
  def notification_text(notification)
    txt = Notification.find(notification.notification_id ).notification.squish
    t = human_readable_time_diff(notification.created_at, Time.now)
    icon = random_icon
    if txt.to_i > 0     
      link_to opportunity_path(Opportunity.find(txt.to_i)) do
    		raw "<span class=\"time\"> #{t}
            </span>
    		<span class=\"details\">
    		<span class=\"label label-sm label-icon label-success\">
    		<i class=\"fa #{icon}\"></i>
    		</span>
    		New invoice pending... </span>"
      end
    else
    	lnk = "<a href=\"javascript:;\">
    		<span class=\"time\">#{t}
            </span>
    		<span class=\"details\">
    		<span class=\"label label-sm label-icon label-success\">
    		<i class=\"fa #{icon}\"></i>
    		</span>
    		#{txt} </span>
        </a>"
        return raw lnk
    end
  end
end
