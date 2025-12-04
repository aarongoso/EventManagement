class Booking < ApplicationRecord
  # Associations
  # optional: true added because we removed Devise (no auth used)
  belongs_to :user, optional: true   # test suite will be updated
  belongs_to :event

  # Validations
  validates :status, presence: true, inclusion: { in: %w[pending confirmed cancelled] }

  # Custom Validation
  validate :event_capacity_not_exceeded

  private

  def event_capacity_not_exceeded
    # Skip validation if no associated event is found
    return unless event.present?

    if event.bookings.count >= event.capacity
      errors.add(:base, "Event is full. Cannot create booking.")
    end
  end
end
