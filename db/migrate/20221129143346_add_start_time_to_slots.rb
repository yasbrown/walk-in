class AddStartTimeToSlots < ActiveRecord::Migration[7.0]
  def change
    add_column :slots, :start_time, :time
    add_column :slots, :end_time, :time
  end
end
