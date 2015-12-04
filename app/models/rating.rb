class Rating < ActiveRecord::Base
  belongs_to :rateable, :polymorphic => true
  belongs_to :user

  def tour_name
    tour = Tour.find_by(id: self.rateable_id)
    tour.title
  end

  def site_name
    site = Site.find_by(id: self.rateable_id)
    site.title
  end

  validates :score, numericality: { only_integer: true, 
                                    greater_than_or_equal_to: 1,
                                    less_than_or_equal_to: 5 }
end
