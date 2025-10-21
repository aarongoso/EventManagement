class Event < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :bookings, dependent: :destroy

  # Validations
  validates :title, presence: true, length: { minimum: 3 }
  validates :description, presence: true, length: { minimum: 10 }
  validates :location, presence: true
  validates :date, presence: true
  validates :time, presence: true
  validates :capacity, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
