class CoversController < ApplicationController

  def create
    @cover = Cover.new(covers_params)
  end

  private

  def covers_params
    params.require(:cover).permit(:seats, :restaurant_id)
  end
end
