class Tour < ActiveRecord::Base
  belongs_to :user
  has_many :sites
  has_many :reviews, as: :reviewable
  has_many :ratings, as: :rateable
end
