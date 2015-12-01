class Review < ActiveRecord::Base
  belongs_to :reviewed, :polymorphic => true
end
