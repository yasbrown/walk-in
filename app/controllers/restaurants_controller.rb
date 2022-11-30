class RestaurantsController < ApplicationController
  def index
    if params[:query].present?
      @restaurants = Restaurant.where.(address: params[:query])
    else
      @restaurants = Restaurant.all
    end
 end

  def show
    @restaurant = Restaurant.find(params[:id])
  end
end
