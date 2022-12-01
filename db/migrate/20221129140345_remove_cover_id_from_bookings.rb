class RemoveCoverIdFromBookings < ActiveRecord::Migration[7.0]
  def change
    remove_column :bookings, :cover_id
  end
end
