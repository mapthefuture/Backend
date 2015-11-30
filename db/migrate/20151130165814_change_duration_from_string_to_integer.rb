class ChangeDurationFromStringToInteger < ActiveRecord::Migration
  def change
    remove_column :tours, :duration, :interval
    add_column :tours, :duration, :integer
  end
end
