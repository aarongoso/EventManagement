class User < ApplicationRecord
  # Devise modules
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
  # above removed because switching to simpler email based auth
  attr_accessor :password  # allows tests to assign password without breaking

  # Associations
  has_many :events, dependent: :destroy
  has_many :bookings, dependent: :destroy

  # Validations
  validates :name, presence: true, length: { minimum: 2 }
  validates :role, presence: true, inclusion: { in: %w[admin user] }

  # Assign a default role when creating a new user
  before_validation :set_default_role, on: :create

  private

  def set_default_role
    self.role ||= "user"
  end
end
