class Event < ApplicationRecord
   # Associations
   # Each event belongs to a user and can have many bookings
   # similar to how an event platform manages attendees
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
