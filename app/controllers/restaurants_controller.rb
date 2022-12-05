class RestaurantsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params.present?
      restaurant_address = params.dig(:restaurant, :address)
      date = params.dig(:restaurant, :date)
      needed_seats = params.dig(:restaurant, :total_seats_available).to_i
      needed_after = params.dig(:restaurant, :opening_time).to_i
      needed_before = params.dig(:restaurant, :closing_time).to_i
      restaurants_by_address = Restaurant.where("address LIKE ?", "%#{restaurant_address.capitalize}%")

      if params.has_key?(:cuisine) || params.has_key?(:rating)
        cuisine = params[:cuisine] if params[:cuisine].present?
        rating = params[:rating].to_f if params[:rating].present?
        if params.has_key?(:cuisine)
          restaurants_by_address = restaurants_by_address.where("cuisine LIKE ?", cuisine)
        end
        if params.has_key?(:rating)
          restaurants_by_address = restaurants_by_address.where("rating >= ?", rating)
        end
      end

      restaurant_by_address_ids = restaurants_by_address.map { |restaurant| restaurant.id }

      covers = Cover.where("seats > ?", needed_seats).where(restaurant_id: restaurant_by_address_ids)
      cover_ids = covers.map { |cover| cover.id }
      slots = Slot.where("start_time >= ?", needed_after).where("start_time <= ?", needed_before).where(cover_id: cover_ids).where("date = ?", date)

      restaurant_ids = slots.map { |slot| slot.restaurant.id }
      @restaurants = Restaurant.where(id: restaurant_ids)

      @params = request.query_parameters["restaurant"]
    else
      @restaurants = Restaurant.all
    end

    @markers = @restaurants.geocoded.map do |restaurant|
      {
        lat: restaurant.latitude,
        lng: restaurant.longitude
      }
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    needed_seats = params.dig(:query, :needed_seats).to_i
    available_covers = @restaurant.covers.where("seats > ?", needed_seats)
    available_covers_ids = available_covers.map { |cover| cover.id }

    date = params.dig(:query, :date)
    needed_after = params.dig(:query, :needed_after).to_i
    needed_before = params.dig(:query, :needed_before).to_i
    @available_slots = @restaurant.slots.where("start_time >= ?", needed_after).where("start_time <= ?", needed_before).where("date = ?", date).where(cover_id: available_covers_ids)

    @markers = [{lat: @restaurant.latitude, lng: @restaurant.longitude}]
    @params = request.query_parameters["query"]
  end
end
