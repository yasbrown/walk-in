class Slot < ApplicationRecord
  has_many :bookings, dependent: :destroy
  belongs_to :cover
  has_one :restaurant, through: :cover
end
