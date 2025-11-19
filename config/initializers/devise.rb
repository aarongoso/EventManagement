# frozen_string_literal: true

Devise.setup do |config|
  # The secret key used by Devise. Devise uses this key to generate
  # random tokens. Changing this key will render invalid all existing
  # confirmation, reset password and unlock tokens in the database.
  # Devise will use the `secret_key_base` as its `secret_key`
  # by default. You can change it below and use your own secret key.
  # config.secret_key = '7f2e...'

  # ==> Controller configuration
  # Configure the parent class to the devise controllers.
  # config.parent_controller = 'DeviseController'

  # ==> Mailer Configuration
  config.mailer_sender = "please-change-me-at-config-initializers-devise@example.com"

  # ==> ORM configuration
  require "devise/orm/active_record"

  # ==> Configuration for any authentication mechanism
  config.case_insensitive_keys = [ :email ]
  config.strip_whitespace_keys = [ :email ]

  # This prevents Devise from storing session for HTTP basic auth
  config.skip_session_storage = [ :http_auth ]

  # ==> Turbo / Rails 8 compatibility (REQUIRED)
  #
  # Devise must use 422 for errors & 303 (see_other) for redirects when Turbo is enabled.
  # Rails 8 turned Turbo on by default, so these two lines are required.
  config.responder.error_status = :unprocessable_entity
  config.responder.redirect_status = :see_other

  # ==> Configuration for :database_authenticatable
  config.stretches = Rails.env.test? ? 1 : 12

  # ==> Configuration for :validatable
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  # ==> Configuration for :recoverable
  config.reset_password_within = 6.hours

  # ==> Configuration for :rememberable
  config.expire_all_remember_me_on_sign_out = true

  # ==> Navigation configuration
  #
  # Turbo needs HTML + turbo_stream formats to behave correctly
  config.navigational_formats = [ "*/*", :html, :turbo_stream ]

  # Ensure Devise uses DELETE for logging out — required for security
  config.sign_out_via = :delete

  # ==> Confirmable
  config.reconfirmable = true

  # ==> OmniAuth
  # config.omniauth :github, 'APP_ID', 'APP_SECRET', scope: 'user,public_repo'

  # ==> Warden configuration
  # config.warden do |manager|
  #   manager.intercept_401 = false
  # end

  # ==> Hotwire/Turbo (already configured above)
  # config.responder.error_status = :unprocessable_entity
  # config.responder.redirect_status = :see_other
end
