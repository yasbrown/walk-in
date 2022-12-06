class FavouriteRestaurantsController < ApplicationController
  def create
    if !current_user
      redirect_to new_user_registration_path
    end
    @restaurant = Restaurant.find(params[:restaurant_id])
    @favourite_restaurant = FavouriteRestaurant.new
    @favourite_restaurant.restaurant = @restaurant
    @favourite_restaurant.user = current_user
    @favourite_restaurant.save!
    redirect_to user_path(current_user)
  end

  def destroy
    # @favourite_restaurant = FavouriteRestaurant.find(params[:id])
    # @favourite_restaurant.destroy
  end
end
