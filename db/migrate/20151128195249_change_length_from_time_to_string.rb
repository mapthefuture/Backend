class ChangeLengthFromTimeToString < ActiveRecord::Migration
  def change
    change_column :tours, :length, :string
  end
end
