class BookingsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @booking = Booking.new(booking_params)
    @booking.user_id = current_user
    @booking.save!
    redirect_to confirmation_path(@booking)
  end

  def destroy
    @booking = Booking.find(:id)
    @booking.destroy
  end

  def confirm
    @restaurant = Restaurant.find(params[:id])
  end

  private

  def booking_params
    params.require(:booking).permit(:user_id, :slot_id, :start_time, :end_time)
  end
end
