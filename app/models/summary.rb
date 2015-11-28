class Summary < ActiveRecord::Base
  belongs_to :site

  has_attached_file :image 
  validates_attachment_file_name :image, matches: [
    /gif\Z/, /gifv\Z/, /png\Z/, /jpg\Z/, /jpeg\Z/
  ]
  has_attached_file :audio
end
