class Country < ApplicationRecord
  has_many :airports
  validates :name, presence: true
  validates :iso, presence: true, uniqueness: { case_sensitive: false }
end
