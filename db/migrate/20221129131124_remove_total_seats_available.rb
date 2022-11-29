class RemoveTotalSeatsAvailable < ActiveRecord::Migration[7.0]
  def change
    remove_column(:restaurants, :total_seats_available)
  end
end
