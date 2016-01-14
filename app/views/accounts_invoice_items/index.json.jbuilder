json.array!(@accounts_invoice_items) do |accounts_invoice_item|
  json.extract! accounts_invoice_item, :id, :description, :units, :unit_cost, :subtotal
  json.url accounts_invoice_item_url(accounts_invoice_item, format: :json)
end
