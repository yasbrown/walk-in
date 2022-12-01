class AddSeatsToCover < ActiveRecord::Migration[7.0]
  def change
    add_column :covers, :seats, :integer
  end
end
