class Site < ActiveRecord::Base
  belongs_to :tour
  has_many :ratings, as: :rated

  has_attached_file :image 
  # validates_attachment_file_name :image, matches: [/png\Z/, /jpg\Z/, /jpeg\Z/]
  has_attached_file :audio
end
