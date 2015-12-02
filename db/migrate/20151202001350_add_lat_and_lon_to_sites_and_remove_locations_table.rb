class AddLatAndLonToSitesAndRemoveLocationsTable < ActiveRecord::Migration
  def change
    add_column :sites, :lat, :decimal, precision: 10, scale: 8
    add_column :sites, :lon, :decimal, precision: 10, scale: 8
    drop_table :locations
  end
end
