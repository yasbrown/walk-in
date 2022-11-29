class FavouriteRestaurantsController < ApplicationController
  def create
    @favourite_restaurant = FavouriteRstaurant.new(params[:id])
    @favourite_restaurant.save
  end

  def destroy
    @favourite_restaurant = FavouriteRstaurant.find(params[:id])
    @favourite_restaurant.destroy
  end
end
