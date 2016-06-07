json.array!(@admissions) do |admission|
  json.extract! admission, :id, :training_id
  json.url admission_url(admission, format: :json)
end
