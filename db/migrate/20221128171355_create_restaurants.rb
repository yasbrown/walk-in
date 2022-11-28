class CreateRestaurants < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.integer :rating
      t.text :address
      t.integer :total_seats_available
      t.string :cuisine

      t.timestamps
    end
  end
end
