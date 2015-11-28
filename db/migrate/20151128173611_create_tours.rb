class CreateTours < ActiveRecord::Migration
  def change
    create_table :tours do |t|
      t.string :title
      t.time :length
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
