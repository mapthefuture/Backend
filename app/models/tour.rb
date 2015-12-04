class Tour < ActiveRecord::Base
  belongs_to :user
  has_many :sites, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :ratings, as: :rateable, dependent: :destroy
  has_many :favorites, as: :favoritable, dependent: :destroy
end
