class Restaurant < ApplicationRecord
  has_many :covers, :favourite_restaurants, dependent: :destroy

  validates :name, presence: true
  validates :rating, presence: true
  validates :address, presence: true
  validates :total_seats_available, presence: true
  validates :cuisine, presence: true

end
