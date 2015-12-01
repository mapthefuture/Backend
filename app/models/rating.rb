class Rating < ActiveRecord::Base
  belongs_to :rated, :polymorphic => true
end
