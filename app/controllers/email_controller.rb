class EmailController < ApplicationController
  # POST /send_confirmation
  def send_confirmation
    # static user id (no Devise)
    user = User.find(params[:user_id])
    event = Event.find(params[:event_id])

    # send the email using ActionMailer
    UserMailer.booking_confirmation(user, event).deliver_now

    # JSON response for React frontend
    render json: { message: "Confirmation email sent successfully." }, status: :ok
  rescue StandardError => e
    # basic error handling pattern fromm labs
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
