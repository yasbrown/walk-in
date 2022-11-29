class UsersController < ApplicationController
  def show
    @user = current_user
    @restaurant = Restaurant.find(params[:restaurant_id])
    @booking = Booking.find(params[:booking_id])
  end
end
