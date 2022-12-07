class FavouriteRestaurantsController < ApplicationController
  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @favourite_restaurant = FavouriteRestaurant.new
    @favourite_restaurant.restaurant = @restaurant
    @favourite_restaurant.user = current_user
    @favourite_restaurant.save!
  end

  def destroy
    # @favourite_restaurant = FavouriteRestaurant.find(params[:id])
    # @favourite_restaurant.destroy
  end
end
