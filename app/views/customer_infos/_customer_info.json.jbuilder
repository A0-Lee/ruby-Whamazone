json.extract! customer_info, :id, :user_id, :customerName, :telephone, :address, :city, :county, :postcode, :created_at, :updated_at
json.url customer_info_url(customer_info, format: :json)
