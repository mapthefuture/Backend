json.sites @sites do |site|
  json.extract! site, :id, :title, :description, :image_file_name, :audio_file_name, :latitude, :longitude, :street, :city, :state, :zip, :country
end

json.warning do
  json.error @errors
end