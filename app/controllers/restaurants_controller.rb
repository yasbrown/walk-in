class RestaurantsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params.present? && !params.has_key?(:rating) && !params.has_key?(:cuisine)

    #   range = ((params.dig(:restaurant, :opening_time).to_i)..params.dig(:restaurant, :closing_time).to_i - 1).to_a
    #   restaurant_address = params.dig(:restaurant, :address)
    #   date = params.dig(:restaurant, :date)
    #   seats = params.dig(:restaurant, :total_seats_available)
    #   @restaurants = []
    #   restaurants = Restaurant.where("address LIKE ?", "%#{restaurant_address}%")
    #   range.each do |time|
    #     @restaurants << restaurants.each do |restaurant|
    #       restaurant.covers.where("seats > ?", seats) &&
    #         restaurant.slots.where(start_time: time).where(available?: true).where(date: date)
    #     end
    #     @restaurants = @restaurants.flatten
    #   end
    # elsif @restaurants.empty?
    #   @restaurants = Restaurant.all
    # else
    #   puts "sorry we are still not there.."
      @restaurants = Restaurant.all
    end

    # @markers = @restaurants.geocoded.map do |restaurant|
    #   {
    #     lat: restaurant.latitude,
    #     lng: restaurant.longitude
    #   }
    # end

    @params = request.query_parameters
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @available_slots = @restaurant.covers.map(&:slots).flatten.select(&:available?).map(&:start_time).uniq.sort

    @markers = [{ lat: @restaurant.latitude, lng: @restaurant.longitude }]

    @params = request.query_parameters
  end

end
