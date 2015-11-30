class AddPtLatAndLong < ActiveRecord::Migration
  def change
    add_column :tours, :start_lat, :decimal, precision: 10, scale: 8
    add_column :tours, :start_lon, :decimal, precision: 10, scale: 8
    add_column :tours, :category, :string
  end
end
