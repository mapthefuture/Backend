class RemoveLengthFromTours < ActiveRecord::Migration
  def change
    remove_column :tours, :length
  end
end
