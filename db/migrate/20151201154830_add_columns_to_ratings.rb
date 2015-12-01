class AddColumnsToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :rated_id, :integer
    add_column :ratings, :rated_type, :string
    add_column :ratings, :score, :integer
  end
end
