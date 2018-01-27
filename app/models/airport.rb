class Airport < ApplicationRecord
  belongs_to :country
  has_many :departures, class_name: "Flight", foreign_key: "origin_id"
  has_many :arrivals, class_name: "Flight", foreign_key: "destination_id"
  validates :iata, presence: true,
                   uniqueness: { case_sensitive: false }
  validates :name, presence: true
  
  def self.list
    grouped_list = {}
    includes(:country).order("countries.name", :name).each do |a|
      grouped_list[a.country.name] ||= [["#{a.country.iso} #{a.country.name}", a.country.iso]]
      grouped_list[a.country.name] << ["#{a.iata} #{a.name} (#{a.municipality}, #{a.country.name})", a.iata]
    end
    grouped_list
  end
end
