json.ratings @ratings do |rating|
  json.extract! rating, :id, :score, :rateable_id, :rateable_type
end