class RemoveBookingCover < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :bookings, :covers
  end
end
