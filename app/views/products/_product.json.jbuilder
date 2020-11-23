json.extract! product, :id, :name, :description, :category, :image_url, :price, :quantityInStock, :created_at, :updated_at
json.url product_url(product, format: :json)
