class ChangeLatAndLonDataTypesAndRemoveDecimalColumn < ActiveRecord::Migration
  def change
    change_column :sites, :lat, :decimal, precision: 10, scale: 8
    change_column :sites, :lon, :decimal, precision: 10, scale: 8
    remove_column :sites, :decimal, :float
  end
end
