class ApplicationController < ActionController::Base
  # Prevent CSRF issues when sending JSON from React
  protect_from_forgery with: :null_session, prepend: true

  # Allow requests from React dev server (Rails 8 requires this for cross origin POSTs)
  skip_forgery_protection if: -> { request.format.json? }

  private
end
