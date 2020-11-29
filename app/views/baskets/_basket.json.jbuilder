json.extract! basket, :id, :user_id, :customerName, :address, :city, :county, :postcode, :created_at, :updated_at
json.url basket_url(basket, format: :json)
