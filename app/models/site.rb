class Site < ActiveRecord::Base
  belongs_to :tour
  has_many :ratings, as: :rateable, dependent: :destroy

  has_attached_file :image 
  has_attached_file :audio

  validates_attachment_file_name :image, matches: [/png\Z/, /jpe?g\Z/]
  # validates_attachment_content_type :image, content_type: /\Aimage/
  # validates_attachment_content_type :audio,
  # :content_type => [ 'audio/mpeg', 'audio/x-mpeg', 'audio/mp3', 
  #                    'audio/x-mp3', 'audio/mpeg3', 'audio/x-mpeg3', 
  #                    'audio/mpg', 'audio/x-mpg', 'audio/x-mpegaudio',
  #                    'audio/m4a' ]

  # geocoded_by :address   # can also be an IP address
  # after_validation :geocode          # auto-fetch coordinates

  # reverse_geocoded_by :latitude, :longitude
  # after_validation :reverse_geocode  # auto-fetch address

  # def address
  # [self.street, self.city, self.state, self.zip, self.country].compact.join(', ')
  # end
end
