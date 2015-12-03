class Tour < ActiveRecord::Base
  belongs_to :user
  has_many :sites, dependent: :destroy
  has_many :reviews, as: :reviewable, dependent: :destroy
  has_many :ratings, as: :rateable, dependent: :destroy

  validates :score, numericality: { only_integer: true, 
                                    greater_than_or_equal_to: 1,
                                    less_than_or_equal_to: 5 }
end
