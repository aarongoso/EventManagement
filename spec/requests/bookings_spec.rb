require "rails_helper"

RSpec.describe "Bookings API", type: :request do
  let!(:demo_user) { User.create!(id: 1, name: "Demo User", email: "demo@example.com") }
  let!(:event) { create(:event, user: demo_user) }

  describe "POST /bookings.json" do
    it "creates a booking successfully" do
      post "/bookings.json", params: {
        booking: {
          user_id: 1,
          event_id: event.id,
          status: "confirmed"
        }
      }

      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(json["event_id"]).to eq(event.id)
    end
  end

  describe "DELETE /bookings/:id.json" do
    let!(:booking) { create(:booking, user: demo_user, event: event) }

    it "deletes a booking" do
      expect {
        delete "/bookings/#{booking.id}.json"
      }.to change(Booking, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
