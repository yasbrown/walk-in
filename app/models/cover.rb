class Cover < ApplicationRecord
  belongs_to :restaurant
  has_many :bookings, dependent: :destroy
end
