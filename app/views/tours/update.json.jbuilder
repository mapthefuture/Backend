json.tour do
  json.id @tour.id
  json.user_id @tour.user_id
  json.title @tour.title
  json.distance @tour.distance
  json.duration @tour.duration
  json.start_lat @tour.start_lat
  json.start_lon @tour.start_lon
  json.category @tour.category
  json.description @tour.description
end