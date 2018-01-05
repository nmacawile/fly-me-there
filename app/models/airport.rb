class Airport < ApplicationRecord
  belongs_to :country
  has_many :departures, class_name: "Flight", foreign_key: "origin_id"
  has_many :arrivals, class_name: "Flight", foreign_key: "destination_id"
  validates :iata, presence: true,
                   uniqueness: { case_sensitive: false }
  validates :name, presence: true
end
