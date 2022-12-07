class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @bookings = Booking.where(user_id: current_user.id)
    @last_booking = @bookings.last
    @favourites = current_user.favourite_restaurants

    @restaurant = Restaurant.find(params[:id])

    @markers = [{ lat: @last_booking.restaurant.latitude, lng: @last_booking.restaurant.longitude }]
  end
end
