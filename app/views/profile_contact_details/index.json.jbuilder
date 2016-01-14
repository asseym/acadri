json.array!(@profile_contact_details) do |profile_contact_detail|
  json.extract! profile_contact_detail, :id, :address, :email_address, :business_phone, :mobile_phone, :home_phone, :fax
  json.url profile_contact_detail_url(profile_contact_detail, format: :json)
end
