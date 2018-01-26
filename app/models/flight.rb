class Flight < ApplicationRecord
  belongs_to :origin, class_name: "Airport"
  belongs_to :destination, class_name: "Airport"
  has_many :bookings
  has_many :passengers, through: :bookings, source: :user
  validates :capacity, numericality: { greater_than: 0 }
  validates :fare, numericality: { greater_than_or_equal_to: 0 }
  validates :depart, presence: true
  validates :arrive, presence: true
  validate :arrive_must_be_later_than_depart
  
  default_scope { order(created_at: :desc) }
  
  def available_seats
    capacity - passengers.count
  end
  
  def duration
    difference = TimeDifference.between(depart, arrive).in_general
    "#{"%02d" % difference[:hours]}h #{"%02d" %  difference[:minutes]}"
  end
  
  def self.search_route(origin = nil, destination = nil)
    if !origin.blank? && !destination.blank? 
      joins(:origin, :destination)
      .where(airports: { iata: origin },
      "destinations_flights": { iata: destination })
    elsif !origin.blank?
      joins(:origin)
      .where(airports: {iata: origin})
    elsif !destination.blank?
      joins(:destination)
     .where(airports: {iata: destination})
    else
      all
    end
  end
  
  def self.search_departure(departure = nil)
    unless departure.blank?
      depart_start = DateTime.strptime(departure, "%m/%d/%Y")
      depart_end = depart_start + 1.day
      where(depart: depart_start..depart_end)
    else
      all
    end
  end
  
  def self.with_enough_seats_for(seats = nil)
    unless seats.blank?
      left_joins(:passengers)
     .group("flights.id")
     .select("flights.*")
     .having("flights.capacity - COUNT(flights.id) >= ?", seats)
   else
     all
   end
  end
  
  private
  
    def arrive_must_be_later_than_depart
      if arrive.present? && depart.present? && arrive < depart
        errors.add(:arrive, "is invalid.")
      end
    end
end
