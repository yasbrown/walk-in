class RestaurantsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params.present?
      query = "address ILIKE ? AND opening_time <= ? AND closing_time >= ? AND total_seats_available >= ?"
      address = params.dig(:restaurant, :address)
      opening_time = params.dig(:restaurant, :opening_time)
      closing_time = params.dig(:restaurant, :closing_time)
      total_seats_available = params.dig(:restaurant, :total_seats_available)
      @restaurants = Restaurant.where(query, "%#{address}%", opening_time, closing_time, total_seats_available)
      if @restaurants.empty?
        @restaurants = Restaurant.all
      end
    else
      puts "sorry we are still not there.."
      @restaurants = Restaurant.all
    end

    @restaurants_all = Restaurant.all
    @markers = @restaurants_all.geocoded.map do |restaurant|
      {
        lat: restaurant.latitude,
        lng: restaurant.longitude
      }
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @availabe_slots = @restaurant.covers.map(&:slots).flatten.select(&:available?).map(&:start_time).uniq.sort

    @markers = [{ lat: @restaurant.latitude, lng: @restaurant.longitude }]
  end
end
