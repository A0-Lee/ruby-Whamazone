json.extract! order, :id, :basket_id, :card_number, :svc_number, :totalCost, :message, :orderDate, :deliveryDate, :created_at, :updated_at
json.url order_url(order, format: :json)
