class Tour < ActiveRecord::Base
  belongs_to :user
  has_many :sites, dependent: :destroy
  has_many :reviews, as: :reviewable, dependent: :destroy
  has_many :ratings, as: :rateable, dependent: :destroy
end
