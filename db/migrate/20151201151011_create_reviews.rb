class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :tagline
      t.text :body
      t.integer :reviewed_id
      t.string :reviewed_type
      t.timestamps null: false
    end
  end
end
