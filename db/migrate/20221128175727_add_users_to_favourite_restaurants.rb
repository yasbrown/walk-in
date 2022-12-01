class AddUsersToFavouriteRestaurants < ActiveRecord::Migration[7.0]
  def change
    add_reference :favourite_restaurants, :user, null: false, foreign_key: true
  end
end
