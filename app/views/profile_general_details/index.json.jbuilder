json.array!(@profile_general_details) do |profile_general_detail|
  json.extract! profile_general_detail, :id, :education, :staff_id, :date_hired, :passport_number, :drivers_licence, :salary, :NSSF_number
  json.url profile_general_detail_url(profile_general_detail, format: :json)
end
