class RestaurantsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params.present?
      @restaurants = Restaurant.where("address ILIKE ? AND opening_time <= ? AND closing_time >= ?", params.dig(:restaurant, :address), params.dig(:restaurant, :opening_time), params.dig(:restaurant, :closing_time))
      if @restaurants.empty?
        @restaurants = Restaurant.all
      end
    else
      puts "sorry we are still not there.."
      @restaurants = Restaurant.all
    end

    # address = params.dig(:restaurant, :address)
    # if address.present?
    #   @restaurants = Restaurant.where.(address: address)
    #   @markers = @restaurants.geocoded.map do |restaurant|
    #     {
    #       lat: restaurant.latitude,
    #       lng: restaurant.longitude
    #     }
    #   end
    # else
      @restaurants = Restaurant.all
      @markers = @restaurants.geocoded.map do |restaurant|
        {
          lat: restaurant.latitude,
          lng: restaurant.longitude
        }
      end

    # end


    end
 end

  def show
    @restaurant = Restaurant.find(params[:id])
    @availabe_slots = @restaurant.covers.map(&:slots).flatten.select(&:available?).map(&:start_time).uniq.sort

    @markers = [{ lat: @restaurant.latitude, lng: @restaurant.longitude }]
  end
end
