class AddDateToRestaurants < ActiveRecord::Migration[7.0]
  def change
    add_column :restaurants, :date, :date
  end
end
