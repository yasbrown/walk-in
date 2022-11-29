class AddOpeningTimeToRestaurants < ActiveRecord::Migration[7.0]
  def change
    add_column :restaurants, :opening_time, :time
  end
end
