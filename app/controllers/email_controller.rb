class EmailController < ApplicationController
  # POST /send_confirmation
  def send_confirmation
    # static user id (no Devise)
    # making sure demo user always exists (same fix used in BookingsController)
    user = User.find_or_create_by(id: 1) do |u|
      u.name = "Demo User"      # fallback user for testing
      u.email = "demo@example.com"   # using lab style seed values
    end

    # fetch event normally
    event = Event.find(params[:event_id])

    # send the email using ActionMailer
    # following examples from ActionMailer lecture
    UserMailer.booking_confirmation(user, event).deliver_nowt

    # JSON response for React frontend
    render json: { message: "Confirmation email sent successfully." }, status: :ok
  rescue StandardError => e
    # basic error handling pattern fromm labs
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
