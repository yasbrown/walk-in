class RestaurantsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params[:query].present?
      @restaurants = Restaurant.where.(address: params[:query])
      @markers = @restaurants.geocoded.map do |restaurant|
        {
          lat: restaurant.latitude,
          lng: restaurant.longitude
        }
      end
    else
      @restaurants = Restaurant.all
      @markers = @restaurants.geocoded.map do |restaurant|
        {
          lat: restaurant.latitude,
          lng: restaurant.longitude
        }
      end
    end
 end

  def show
    @restaurant = Restaurant.find(params[:id])
  end
end
