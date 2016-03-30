json.array!(@accounts_invoices) do |accounts_invoice|
  json.extract! accounts_invoice, :id, :training_id, :invoice_date, :invoice_terms, :currency
  json.url accounts_invoice_url(accounts_invoice, format: :json)
end
