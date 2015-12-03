json.rating do
  json.extract! @rating, :id, :score, :rateable_id, :rateable_type
end