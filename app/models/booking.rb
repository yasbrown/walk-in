class Booking < ApplicationRecord
  belongs_to :slot
  belongs_to :user
  has_one :restaurant, through: :slot

  validates :start_time, presence: true
  validates :end_time, presence: true
  # validate :time_cannot_be_in_the_past

  # def time_cannot_be_in_the_past
  #   if :start_time < Time.now
  #     errors.add(:start_time, "can't be in the past")
  #   end
  # end

end
