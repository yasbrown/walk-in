class BookingsController < ApplicationController

  def create
    @booking = Booking.new(booking_params)
    @booking.save!
    redirect_to confirmation_path(@booking)
  end

  def destroy
    @booking = Booking.find(:id)
    @booking.destroy
  end

  private

  def booking_params
    params.require(:booking).permit(:user_id, :slot_id, :start_time, :end_time)
  end
end
