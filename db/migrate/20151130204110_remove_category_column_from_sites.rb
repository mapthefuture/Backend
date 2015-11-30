class RemoveCategoryColumnFromSites < ActiveRecord::Migration
  def change
    remove_column :sites, :category, :string
  end
end
