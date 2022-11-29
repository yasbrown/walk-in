class AddClosingTimeToRestaurants < ActiveRecord::Migration[7.0]
  def change
    add_column :restaurants, :closing_time, :integer
  end
end
