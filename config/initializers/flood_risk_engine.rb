# frozen_string_literal: true

FloodRiskEngine::ApplicationController.layout 'application'

FloodRiskEngine.configure do |config|
  # Last email cache config
  config.use_last_email_cache = ENV["USE_LAST_EMAIL_CACHE"] || "false"

  # Configure airbrake, which is done via the engine using defra_ruby_alert
  config.airbrake_enabled = ENV["USE_AIRBRAKE"]
  config.airbrake_host = Rails.application.secrets.airbrake_host
  config.airbrake_project_key = Rails.application.secrets.airbrake_project_key
  config.airbrake_blocklist = [
    # Catch-all "safety net" regexes.
    /password/i,
    /postcode/i,

    :full_name,

    :name,
    :telephone_number,

    :email,
    :email_address,
    :email_address_confirmation,

    :reset_password_token,
    :confirmation_token,
    :unconfirmed_email,
    :unlock_token,

    # Other things we'll filter beacuse we're super-diligent.
    :_csrf_token,
    :session_id,
    :authenticity_token
  ]

  config.default_assistance_mode = 0

  config.companies_house_api_key = ENV["COMPANIES_HOUSE_API_KEY"]
end
FloodRiskEngine.start_airbrake
