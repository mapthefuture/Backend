class Site < ActiveRecord::Base
  belongs_to :tour
  has_one :summary
end
