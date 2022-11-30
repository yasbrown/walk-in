class RestaurantsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params[:query].present?
      @restaurants = Restaurant.global_search(params[:query])
      if @restaurants.nil?
        @Restaurants = Restaurant.all
      end
    else
      @restaurants = Restaurant.all
    end
 end

  def show
    @restaurant = Restaurant.find(params[:id])
  end
end
