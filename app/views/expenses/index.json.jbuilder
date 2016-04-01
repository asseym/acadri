json.array!(@expenses) do |expense|
  json.extract! expense, :id, :item, :description, :expense_date, :qty, :unit_price, :tax, :invoice_ref
  json.url expense_url(expense, format: :json)
end
