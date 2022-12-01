class AddTotalSeatsAvailableToRestaurants < ActiveRecord::Migration[7.0]
  def change
    add_column :restaurants, :total_seats_available, :integer
  end
end
