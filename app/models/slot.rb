class Slot < ApplicationRecord
  has_many :bookings, dependent: :destroy
  belongs_to :cover
  has_one :restaurant, through: :cover

  validates :restaurant, presence: true
  validates :date, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
end
