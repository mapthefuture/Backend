class AddCategoryColumnToSites < ActiveRecord::Migration
  def change
    add_column :sites, :category, :string
  end
end
