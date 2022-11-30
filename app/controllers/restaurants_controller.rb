class RestaurantsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params[:query].present?
      @restaurants = Restaurant.where.(address: params[:query])
    else
      @restaurants = Restaurant.all
    end
 end

  def show
    @restaurant = Restaurant.find(params[:id])
    @available_slots = @restaurant.covers.map(&:slots).flatten.select(&:available?).map(&:start_time).uniq.sort
  end
end
