class AddSiteIdToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :site_id, :integer
  end
end
