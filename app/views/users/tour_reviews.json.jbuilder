json.tour_reviews @reviews do |review|
  json.id review.id
  json.tagline review.tagline
  json.body review.body
  json.tour_id review.tour_id
end