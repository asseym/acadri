json.array!(@program_dates) do |program_date|
  json.extract! program_date, :id, :date
  json.url program_date_url(program_date, format: :json)
end
