class AddSlotReferenceToBookings < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookings, :slot, null: false, foreign_key: true
  end
end
