json.tour_ratings @ratings do |rating|
  json.tour_id rating.rateable_id
  json.tour_name rating.tour_name
  json.score rating.score
end
