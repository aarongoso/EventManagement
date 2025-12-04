require 'rails_helper'

RSpec.describe Booking, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      booking = build(:booking)
      expect(booking).to be_valid
    end

    it "allows a booking without a user (because user is optional)" do
      booking = build(:booking, user: nil)
      expect(booking).to be_valid
    end

    it "is invalid without an event" do
      booking = build(:booking, event: nil)
      expect(booking).not_to be_valid
    end

    it "is invalid without a status" do
      booking = build(:booking, status: nil)
      expect(booking).not_to be_valid
    end
  end

  describe "associations" do
    it { should belong_to(:user).optional }
    it { should belong_to(:event) }
  end
end
