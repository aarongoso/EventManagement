class UserMailer < ApplicationMailer
  default from: "events@example.com"

  # Sends a confirmation email after a user books an event
  def booking_confirmation(user, event)
    @user = user
    @event = event

    mail(
      to: @user.email,
      subject: "Your booking for #{event.title} is confirmed"
    )
  end
end
