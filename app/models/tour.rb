class Tour < ActiveRecord::Base
  attr_accessor :latitude, :longitude, :address

  belongs_to :user
  has_many :sites, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :ratings, as: :rateable, dependent: :destroy
  has_many :favorites, as: :favoritable, dependent: :destroy

  geocoded_by :address   # can also be an IP address
  after_validation :geocode  # auto-fetch coordinates

  reverse_geocoded_by :start_lat, :start_lon
  after_validation :reverse_geocode  # auto-fetch address

  def address
    [street, city, state, country].compact.join(', ')
  end
end
