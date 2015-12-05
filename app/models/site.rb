class Site < ActiveRecord::Base
  belongs_to :tour
  has_many :ratings, as: :rateable, dependent: :destroy

  has_attached_file :image 
  # validates_attachment_file_name :image, matches: [/png\Z/, /jpg\Z/, /jpeg\Z/]
  has_attached_file :audio

  do_not_validate_attachment_file_type :image
  do_not_validate_attachment_file_type :audio

  # geocoded_by :address   # can also be an IP address
  # after_validation :geocode          # auto-fetch coordinates

  # reverse_geocoded_by :latitude, :longitude
  # after_validation :reverse_geocode  # auto-fetch address

  def address
  [self.street, self.city, self.state, self.zip, self.country].compact.join(', ')
  end
end
