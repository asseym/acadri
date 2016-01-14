json.array!(@accounts_invoices) do |accounts_invoice|
  json.extract! accounts_invoice, :id, :organisation_id, :date, :invoice_details, :invoice_terms, :currency, :amount
  json.url accounts_invoice_url(accounts_invoice, format: :json)
end
