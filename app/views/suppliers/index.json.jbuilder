json.array!(@suppliers) do |supplier|
  json.extract! supplier, :id, :name, :shop_name, :contact_numbers, :address, :town, :country_id, :supply_items_id
  json.url supplier_url(supplier, format: :json)
end
