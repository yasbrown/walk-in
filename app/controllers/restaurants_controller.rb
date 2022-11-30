class RestaurantsController < ApplicationController
  def index
    if params.present?
      @restaurants = Restaurant.where("address ILIKE ? AND opening_time <= ? AND closing_time >= ?", params.dig(:restaurant, :address), params.dig(:restaurant, :opening_time), params.dig(:restaurant, :closing_time))
      if @restaurants.empty?
        @restaurants = Restaurant.all
      end
    else
      @restaurants = Restaurant.all
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end
end
