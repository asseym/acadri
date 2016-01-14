json.array!(@profile_personal_details) do |profile_personal_detail|
  json.extract! profile_personal_detail, :id, :first_name, :other_names, :religion, :sex, :marital_status, :birthday, :nationality, :languages
  json.url profile_personal_detail_url(profile_personal_detail, format: :json)
end
