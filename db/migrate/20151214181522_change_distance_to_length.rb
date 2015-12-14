class ChangeDistanceToLength < ActiveRecord::Migration
  def change
    rename_column :tours, :distance, :length
  end
end
