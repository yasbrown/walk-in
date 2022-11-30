class Slot < ApplicationRecord
  has_many :bookings, dependent: :destroy
  belongs_to :cover
  belongs_to :restaurant
end
