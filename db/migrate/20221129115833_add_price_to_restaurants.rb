class AddPriceToRestaurants < ActiveRecord::Migration[7.0]
  def change
    add_column :restaurants, :price, :integer
  end
end
