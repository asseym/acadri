json.array!(@profile_bank_details) do |profile_bank_detail|
  json.extract! profile_bank_detail, :id, :bank_details
  json.url profile_bank_detail_url(profile_bank_detail, format: :json)
end
