class AddAddressFieldsToTour < ActiveRecord::Migration
  def change
    add_column :tours, :street, :string
    add_column :tours, :city, :string
    add_column :tours, :state, :string
    add_column :tours, :country, :string
    change_column :tours, :category, :string, :null => true
    change_column :reviews, :body, :text, :null => false
    change_column :reviews, :tagline, :string, :null => true
  end
end
