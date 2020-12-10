json.extract! review, :id, :product_id, :user_id, :title, :comment, :rating, :created_at, :updated_at
json.url review_url(review, format: :json)
