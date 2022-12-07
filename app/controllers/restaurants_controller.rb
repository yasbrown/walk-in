class RestaurantsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @params = request.query_parameters["restaurant"]
    if all_search_params_present?
      @restaurant_address = params.dig(:restaurant, :address)
      @date = params.dig(:restaurant, :date)
      @needed_seats = params.dig(:restaurant, :total_seats_available).to_i
      @needed_after = params.dig(:restaurant, :opening_time).to_i
      @needed_before = params.dig(:restaurant, :closing_time).to_i
      restaurants_by_address = Restaurant.where("address LIKE ?", "%#{@restaurant_address.capitalize}%")
      restaurants_by_address = filter_by_cuisine_and_rating(restaurants_by_address)

      restaurant_by_address_ids = restaurants_by_address.map(&:id)

      covers = Cover.where("seats > ?", @needed_seats).where(restaurant_id: restaurant_by_address_ids)
      cover_ids = covers.map(&:id)
      slots = Slot.where("start_time >= ?", @needed_after)
        .where("start_time <= ?", @needed_before)
        .where(cover_id: cover_ids)
        .where("date = ?", @date).uniq

      restaurant_ids = slots.map { |slot| slot.restaurant.id }.uniq
      @restaurants = Restaurant.where(id: restaurant_ids)

      @params = request.query_parameters["restaurant"]

      @markers = @restaurants.geocoded.map do |restaurant|
        {
          lat: restaurant.latitude,
          lng: restaurant.longitude,
          info_window: render_to_string(partial: "shared/popup", locals: { restaurant: restaurant })
        }
      end
    else
      @params = {
        address: "London",
        date: Date.new(2022,12,9),
        total_seats_available: 2,
        opening_time: 9,
        closing_time: 23
      }
      @restaurants = Restaurant.all
      @restaurant_address = "London"
      @date = Date.new(2022,12,9)
      @needed_seats = 2
      @needed_after = 9
      @needed_before = 23

      @restaurants = filter_by_cuisine_and_rating(@restaurants)

      @markers = @restaurants.geocoded.map do |restaurant|
        {
          lat: restaurant.latitude,
          lng: restaurant.longitude,
          info_window: render_to_string(partial: "shared/popup", locals: { restaurant: restaurant })
        }
      end
    end
    @restaurant = Restaurant.new
  end

  def show
    @restaurant = Restaurant.find(params[:id])

    needed_seats = params.dig(:restaurant, :total_seats_available).to_i
    available_covers = @restaurant.covers.where("seats >= ?", needed_seats)
    available_covers_ids = available_covers.map(&:id)

    date = params.dig(:restaurant, :date).present? ? params.dig(:restaurant, :date) : Date.new(2022,12,9)
    needed_after = params.dig(:restaurant, :opening_time).present? ? params.dig(:restaurant, :opening_time).to_i : 9
    needed_before = params.dig(:restaurant, :closing_time).present? ? params.dig(:restaurant, :closing_time).to_i : 21
    @available_slots = @restaurant.slots.where(available?: true)
          .where("start_time >= ?", needed_after)
          .where("start_time <= ?", needed_before)
          .where("date = ?", date)
          .where(cover_id: available_covers_ids).select(:start_time).distinct


    @markers = [{ lat: @restaurant.latitude, lng: @restaurant.longitude }]
    if all_search_params_present?
      @params = request.query_parameters["restaurant"]
    else
      @params = {
        address: "London",
        date: Date.new(2022,12,9),
        total_seats_available: 2,
        opening_time: 9,
        closing_time: 23
      }
    end
    # @params = request.query_parameters["restaurant"]
    @restaurant_sample = Restaurant.where("rating > 4").sample
  end

  private

  def filter_by_cuisine_and_rating(restaurants)
    if params[:restaurant].has_key?(:cuisine) || params[:restaurant].has_key?(:rating)
      cuisine = params[:restaurant][:cuisine][1] if params[:restaurant][:cuisine][1].present?
      rating = params[:restaurant][:rating] if params[:restaurant][:rating].present?
      if params[:restaurant].has_key?(:cuisine)
        restaurants = restaurants.where("cuisine LIKE ?", cuisine)
      end
      if params[:restaurant].has_key?(:rating)
        restaurants = restaurants.where("rating >= ?", rating)
      end
    end
    restaurants
  end

  def all_search_params_present?
    params[:restaurant].present? &&
    params.dig(:restaurant, :address).present? &&
    params.dig(:restaurant, :date).present? &&
    params.dig(:restaurant, :total_seats_available).present? &&
    params.dig(:restaurant, :opening_time).present? &&
    params.dig(:restaurant, :closing_time).present?
  end
end
