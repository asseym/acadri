json.array!(@participants) do |participant|
  json.extract! participant, :id, :name, :other_names, :sex, :passport_no, :job_title, :organisation_id
  json.url participant_url(participant, format: :json)
end
