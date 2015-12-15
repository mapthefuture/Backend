class Site < ActiveRecord::Base
  belongs_to :tour
  has_many :ratings, as: :rateable, dependent: :destroy

  has_attached_file :image 
  has_attached_file :audio

  validates_attachment_file_name :image, matches: [/png\Z/, /jpe?g\Z/]
  validates_attachment_file_name :audio, matches: [/mp3\Z/, /m4a\Z/]
end
