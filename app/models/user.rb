class User < ApplicationRecord
  has_many :bookings
  has_many :flights_booked, through: :bookings, source: :flight
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
end
