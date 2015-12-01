class RemoveSummariesAndAddColumnsToSites < ActiveRecord::Migration
  def change
    add_column :sites, :description, :text
    add_column :sites, :image_file_name, :string
    add_column :sites, :audio_file_name, :string
    drop_table :summaries
  end
end
