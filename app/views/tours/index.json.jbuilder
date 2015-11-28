json.tours @tours do |tour|
  json.extract! tour, :id, :user_id, :title, :length
end