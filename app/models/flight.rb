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
      if origin.size == 3 && destination.size == 3
        joins(:origin, :destination)
        .where("airports.iata = ? AND destinations_flights.iata = ?", origin, destination)
      elsif origin.size == 3 && destination.size == 2
        joins(:origin, [destination: :country]).where("airports.iata = ? AND countries.iso = ?", origin, destination)
      elsif origin.size == 2 && destination.size == 3
        joins([origin: :country], :destination).where("countries.iso = ? AND destinations_flights.iata = ?", origin, destination)
      else
        joins([origin: :country], [destination: :country]).where("countries.iso = ? AND countries_airports.iso = ?", origin, destination)
      end
    elsif !origin.blank?
      if origin.size == 3
        joins(:origin).where(airports: { iata: origin })
      else
        joins([origin: :country]).where("countries.iso = ?", origin)
      end
    elsif !destination.blank?
      if destination.size == 3
        joins(:destination).where(airports: { iata: destination })
      else
        joins([destination: :country]).where("countries.iso = ?", destination)
      end
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
