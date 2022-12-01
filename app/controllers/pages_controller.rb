class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @restaurant = Restaurant.new
  end
end
