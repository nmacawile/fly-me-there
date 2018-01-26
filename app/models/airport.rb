class Airport < ApplicationRecord
  belongs_to :country
  has_many :departures, class_name: "Flight", foreign_key: "origin_id"
  has_many :arrivals, class_name: "Flight", foreign_key: "destination_id"
  validates :iata, presence: true,
                   uniqueness: { case_sensitive: false }
  validates :name, presence: true
  
  def self.list
    grouped_list = {}
    joins(:country).select(:name, :id, :municipality, :iata, 'countries.name as country_name').order("country_name", :name).each do |a|
      grouped_list[a.country_name] ||= []
      grouped_list[a.country_name] << ["#{a.iata} #{a.name} (#{a.municipality})", a.iata]
    end
    grouped_list
  end
end
