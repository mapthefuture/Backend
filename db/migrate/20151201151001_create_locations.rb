class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.decimal  :lat, precision: 10, scale: 8
      t.decimal  :lon, precision: 10, scale: 8
      t.string   :street_address
      t.string   :city
      t.string   :state
      t.integer  :zip
      t.timestamps null: false
    end
  end
end
