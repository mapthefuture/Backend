class AddTourIdAndRemovePolymorphicAssociationFromReviews < ActiveRecord::Migration
  def change
    remove_column :reviews, :reviewable_id
    remove_column :reviews, :reviewable_type
    add_column :reviews, :user_id, :integer
    add_column :reviews, :tour_id, :integer
  end
end
