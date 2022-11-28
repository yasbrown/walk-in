class CreateFavouriteRestaurants < ActiveRecord::Migration[7.0]
  def change
    create_table :favourite_restaurants do |t|
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
