class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @bookings = Booking.where(user_id: current_user.id)
    @last_booking = @bookings.last
    @favourites = current_user.favourite_restaurants
  end
end
