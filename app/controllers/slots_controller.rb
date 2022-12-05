class SlotsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    date = params.dig(:query, :date)
    needed_at = params.dig(:query, :time).to_i
    @available_slots = @restaurant.slots.where("start_time = ?", needed_at).where("date = ?", date)
  end
end
