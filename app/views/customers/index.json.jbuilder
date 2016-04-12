json.array!(@customers) do |customer|
  json.extract! customer, :id, :name, :content
  json.url customer_url(customer, format: :json)
end
