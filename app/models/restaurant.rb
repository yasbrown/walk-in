class Restaurant < ApplicationRecord
  has_many :covers, dependent: :destroy
  has_many :favourite_restaurants, dependent: :destroy
  has_many :slots, through: :covers
  has_many :reviews, dependent: :destroy

  validates :name, presence: true
  validates :rating, presence: true
  validates :address, presence: true
  validates :cuisine, presence: true
  validates :price, presence: true
  validates :price, numericality: { only_integer: true }
  validates :price, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 3 }
  validates :description, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  include PgSearch::Model
  pg_search_scope :global_search,
  against: [ :address, :opening_time, :closing_time],
  associated_against: {
    covers: [:seats]
  },
  using: {
    tsearch: { prefix: true }
  }



end
