class FavouriteRestaurantsController < ApplicationController
  def create
    if !user_signed_in?
      redirect_to new_user_registration_path
    end

    @restaurant = Restaurant.find(params[:restaurant_id])
    if current_user.favourite_restaurants.where(restaurant_id: @restaurant.id).empty?
      @favourite_restaurant = FavouriteRestaurant.new
      @favourite_restaurant.restaurant = @restaurant
      @favourite_restaurant.user = current_user
      @favourite_restaurant.save!
    else
      redirect_to restaurant_path(@restaurant)
    end
  end

  def destroy
    @favourite_restaurant = FavouriteRestaurant.find(params[:id])
    @favourite_restaurant.destroy!
    redirect_to user_path(current_user), status: :see_other
  end
end
