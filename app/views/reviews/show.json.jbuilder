json.review do
  json.extract! @review, :id, :tagline, :body, :user_id, :tour_id
end