json.site_ratings @ratings do |rating|
  json.site_id rating.rateable_id
  json.site_name rating.site_name
  json.score rating.score
end