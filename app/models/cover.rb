class Cover < ApplicationRecord
  belongs_to :restaurant
  has_many :slots, dependent: :destroy
  validates :seats, presence: true
end
