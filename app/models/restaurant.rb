class Restaurant < ApplicationRecord
  has_many :covers, :favourite_restaurants, dependent: :destroy


  validates :name, presence: true
  validates :rating, presence: true
  validates :address, presence: true
  validates :total_seats_available, presence: true
  validates :cuisine, presence: true
  validates :price, presence: true
  validates :price, numericality: { only_integer: true }
  validates :price, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 3}
  validates :description, presence: true

end
