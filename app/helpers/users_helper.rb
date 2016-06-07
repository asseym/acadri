module UsersHelper
  
  #Return the gravator for a given user
  def gravator_for(user, cls="", options={})
    if !options.empty?
      args = ""
      options.each do |key, value|
        args += "#{key}=#{value}"
      end
    end
    gravator_id = Digest::MD5::hexdigest(user.email.downcase)
    gravator_url = args ? "https://secure.gravatar.com/avatar/#{gravator_id}" + "?" + args :\
     "https://secure.gravatar.com/avatar/#{gravator_id}"
     cls = cls.empty? ? "gravatar" : cls
    image_tag(gravator_url, alt: current_user_name(user), class: cls)
  end

  def current_user_name(user)
    "#{user.profile_personal_detail.first_name} #{user.profile_personal_detail.other_names}"
  end

  def user_job_title(user)
    'Program Coordinator'
  end

  def user_desc(user)
    "Lorem ipsum dolor sit amet diam nonummy nibh dolore."
  end

  def staff_personal_details(user, detail)
    if user.profile_personal_detail
      user.profile_personal_detail.send(detail)
    end
  end

  def is_superadmin(user)
    user.has_role? :superadmin
  end
end
