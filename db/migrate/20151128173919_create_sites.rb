class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :title
      t.float :lat, :decimal, {:precision=>10, :scale=>6}
      t.float :lon, :decimal, {:precision=>10, :scale=>6}
      t.integer :tour_id

      t.timestamps null: false
    end
  end
end
