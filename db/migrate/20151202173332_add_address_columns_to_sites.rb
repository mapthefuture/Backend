class AddAddressColumnsToSites < ActiveRecord::Migration
  def change
    rename_column :sites, :lat, :latitude
    rename_column :sites, :lon, :longitude
    add_column :sites, :street, :string
    add_column :sites, :city, :string
    add_column :sites, :state, :string
    add_column :sites, :zip, :integer
    add_column :sites, :country, :integer
  end
end
