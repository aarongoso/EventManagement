require "rails_helper"

RSpec.describe "Events API", type: :request do
  let!(:demo_user) { User.create!(id: 1, name: "Demo User", email: "demo@example.com") }
  let!(:event) { create(:event, user: demo_user) }

  describe "GET /events.json" do
    it "returns all events as JSON" do
      get "/events.json"
      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)
      expect(json).to be_an(Array)
      expect(json.first["title"]).to eq(event.title)
    end
  end

  describe "POST /events.json" do
    it "creates an event using fallback demo user" do
      post "/events.json", params: {
        event: {
          title: "New Event",
          description: "Event description",
          location: "NCI",
          date: "2025-12-04",
          time: "12:00",
          capacity: 20
        }
      }

      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(json["user_id"]).to eq(1)
    end
  end

  describe "DELETE /events/:id.json" do
    it "deletes an event" do
      expect {
        delete "/events/#{event.id}.json"
      }.to change(Event, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
