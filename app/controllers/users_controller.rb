class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @bookings = Booking.where(user_id: current_user.id)
    @last_booking = @bookings.last
    @favourites = current_user.favourite_restaurants.select(:restaurant_id).distinct
    @restaurant = Restaurant.find(params[:id])

    @markers = [{ lat: @last_booking.restaurant.latitude, lng: @last_booking.restaurant.longitude }]

    @url ="https://www.google.com/maps/dir/?api=1&#{@last_booking.restaurant.latitude}"
  end
end
