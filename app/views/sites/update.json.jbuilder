json.site do 
  json.id @site.id
  json.tour_id @site.tour_id
  json.title @site.title
  json.description @site.description
  json.image_file_name @site.image_file_name
  json.image_url @site.image.url
  json.audio_file_name @site.audio_file_name
  json.audio_url @site.audio.url
  json.latitude @site.latitude
  json.longitude @site.longitude
  json.average_rating @site.ratings.average(:score)
end