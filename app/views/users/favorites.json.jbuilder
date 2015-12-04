json.favorites @favorites do |favorite|
  json.extract! favorite, :id, :user_id, :favoritable_id, :favoritable_type
end