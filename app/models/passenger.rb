class Passenger < ApplicationRecord
  before_save { email.downcase! }
  belongs_to :booking, required: false
  
  def ticket_code
    "#{booking.flight.origin.iata}#{booking.flight.destination.iata}-#{booking.flight.id}-#{booking.id}-#{id}"
  end
  
  validates :name, presence: true
  validates :email, presence: true
end
