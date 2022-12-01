class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    # @booking = Booking.find(params[:booking_id])
  end

end
