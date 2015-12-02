class ChangeColumnNamesInRatingsAndReviews < ActiveRecord::Migration
  def change
    rename_column :ratings, :rated_id, :rateable_id
    rename_column :ratings, :rated_type, :rateable_type
    rename_column :reviews, :reviewed_type, :reviewable_type
    rename_column :reviews, :reviewed_id, :reviewable_id
  end
end
