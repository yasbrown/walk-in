class RestaurantsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

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
    @availabe_slots = @restaurant.covers.map(&:slots).flatten.select(&:available?).map(&:start_time).uniq.sort

    @markers = [{ lat: @restaurant.latitude, lng: @restaurant.longitude }]
  end
end
