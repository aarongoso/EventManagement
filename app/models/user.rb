class User < ApplicationRecord
  has_secure_password

  # Associations
  has_many :events, dependent: :destroy
  has_many :bookings, dependent: :destroy

  # Validations
  validates :name, presence: true, length: { minimum: 2 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role, presence: true, inclusion: { in: %w[admin user] }
end
