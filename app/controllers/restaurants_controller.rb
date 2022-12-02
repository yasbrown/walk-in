class RestaurantsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params.present?
      query = "address ILIKE ? AND opening_time <= ? AND closing_time >= ? AND total_seats_available >= ?"
      @address = params.dig(:restaurant, :address)
      @opening_time = params.dig(:restaurant, :opening_time)
      @closing_time = params.dig(:restaurant, :closing_time)
      @total_seats_available = params.dig(:restaurant, :total_seats_available)
      query2 = "address ILIKE ? AND opening_time <= ? AND closing_time >= ? AND total_seats_available >= ? AND cuisine ? AND rating >= ?"
      @cuisine = params.dig(:restaurant, :cuisine)
      @rating = params.dig(:restaurant, :rating)
      @restaurants = Restaurant.where(query, "%#{@address}%", @opening_time, @closing_time, @total_seats_available)
      if !@cuisine.nil? && !@rating.nil?
        query2 = "address ILIKE ? AND opening_time <= ? AND closing_time >= ? AND total_seats_available >= ? AND cuisine ILIKE ? AND rating >= ?"
        @filtered_restaurants = @restaurants.where(query2, "%#{@address}%", @opening_time, @closing_time, @total_seats_available, @cuisine, @rating)
      end
      @restaurants = Restaurant.all if @restaurants.empty?
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
