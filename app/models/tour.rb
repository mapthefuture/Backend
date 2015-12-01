class Tour < ActiveRecord::Base
  belongs_to :user
  has_many :sites
  has_many :reviews, as: :reviewed
  has_many :ratings, as: :rated
end
