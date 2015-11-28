class CreateSummaries < ActiveRecord::Migration
  def change
    create_table :summaries do |t|
      t.text :text
      t.string :image_file_name
      t.string :audio_file_name
      t.integer :site_id

      t.timestamps null: false
    end
  end
end
