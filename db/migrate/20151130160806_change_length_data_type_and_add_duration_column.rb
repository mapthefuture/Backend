class ChangeLengthDataTypeAndAddDurationColumn < ActiveRecord::Migration
  def change
    remove_column :tours, :length
    add_column :tours, :distance, :float
    add_column :tours, :duration, :interval
  end
end
