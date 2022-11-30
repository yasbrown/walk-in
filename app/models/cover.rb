class Cover < ApplicationRecord
  belongs_to :restaurant
  has_many :slots
  has_many :bookings, through: :slots, dependent: :destroy
  validates :seats, presence: true
end
