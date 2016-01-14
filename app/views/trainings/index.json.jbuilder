json.array!(@trainings) do |training|
  json.extract! training, :id, :participants_id, :program_id, :start_date, :end_date, :fees, :fees_paid, :fees_balance, :program_venue_id
  json.url training_url(training, format: :json)
end
