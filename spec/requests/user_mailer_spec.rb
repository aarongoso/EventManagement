require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  let(:user) { User.create!(id: 1, name: "Demo User", email: "demo@example.com") }
  let(:event) { create(:event, user: user, title: "Test Event") }

  describe "booking_confirmation" do
    let(:mail) { UserMailer.booking_confirmation(user, event) }

    it "sends to the correct user" do
      expect(mail.to).to eq([ "demo@example.com" ])
    end

    it "includes event details" do
      expect(mail.body.encoded).to include("Test Event")
      expect(mail.body.encoded).to include(event.location)
    end
  end
end
