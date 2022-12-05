class BookingsController < ApplicationController
  def create
    @slot = Slot.find(params[:slot_id])
    @booking = Booking.new
    @booking.slot = @slot
    @booking.user = current_user
    @booking.save!
    redirect_to booking_confirmation_path(@booking)
  end

  def destroy
    @booking = Booking.find(:id)
    @booking.destroy
  end

  def confirmation
    @booking = Booking.find(params[:booking_id])
    @restaurant = Restaurant.find(@booking.slot.restaurant.id)
  end

  def my_bookings
    @bookings = Booking.where(user: current_user)
  end

  private

  def booking_params
    params.require(:booking).permit(:slot_id)
  end
end
