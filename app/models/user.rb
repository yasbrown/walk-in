class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :bookings
  has_many :reviews, dependent: :destroy
  validates :name, presence: true
  has_many :favourite_restaurants
  # validates :email, presence: true
  # validates :mobile_number, presence: true # format: { with: /\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\z/ }
  # validates :password, presence: true
  # validates :location, presence: true
end
