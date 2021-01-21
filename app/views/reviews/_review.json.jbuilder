json.extract! review, :id, :body, :rating, :user_id, :book_id, :created_at, :updated_at
json.url review_url(review, format: :json)
