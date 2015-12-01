json.tour do
  json.extract! @tour, :id, :user_id, :title, :distance, :duration, :start_lat, :start_lon, :category, :description
end