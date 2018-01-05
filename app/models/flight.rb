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
  
  private
  
    def arrive_must_be_later_than_depart
      if arrive.present? && depart.present? && arrive < depart
        errors.add(:arrive, "is invalid.")
      end
    end
end
