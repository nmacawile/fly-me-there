class Booking < ApplicationRecord
  has_many :passengers, dependent: :destroy
  belongs_to :flight
  
  validate :validate_passengers_count
  
  accepts_nested_attributes_for :passengers
  
  private
  
    def validate_passengers_count
      errors.add(:flight_id, "does not have enough seats.") if flight.present? && flight.available_seats < passengers.size
    end
end
