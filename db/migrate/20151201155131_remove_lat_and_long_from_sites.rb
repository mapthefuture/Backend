class RemoveLatAndLongFromSites < ActiveRecord::Migration
  def change
    remove_column :sites, :lat
    remove_column :sites, :lon
  end
end
