class AddPhotosToRestaurants < ActiveRecord::Migration[7.0]
  def change
    add_column :restaurants, :photos, :string
  end
end
