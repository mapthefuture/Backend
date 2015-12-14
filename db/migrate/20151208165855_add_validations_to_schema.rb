class AddValidationsToSchema < ActiveRecord::Migration
  def change
    change_column :ratings, :score, :integer, :null => false
    change_column :reviews, :tagline, :string, :null => false
    change_column :sites, :title, :string, :null => false
    change_column :tours, :title, :string, :null => false
    change_column :tours, :category, :string, :null => false
    change_column :users, :email, :string, :null => false
    change_column :users, :first_name, :string, :null => false
    change_column :users, :access_token, :string, :null => false
  end
end
