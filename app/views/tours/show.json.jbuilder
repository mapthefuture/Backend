json.tour do
  json.extract! @tour, :id, :user_id, :title, :length
end