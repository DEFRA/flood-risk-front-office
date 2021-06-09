source "https://rubygems.org"
ruby "2.7.1"

gem "dxw_govuk_frontend_rails"
gem "high_voltage"
gem "jquery-rails"
gem "pg"
gem "pundit"
gem "rails", "~> 6.0.3"
gem "sass-rails"
gem "uglifier"
gem "whenever"

gem "flood_risk_engine",
    git: "https://github.com/DEFRA/flood-risk-engine",
    branch: "chore/upgrade-to-rails-6"

gem "github_changelog_generator", require: false

# Automatically loads environment variables from .env into ENV. Specified here
# rather than in the group in case any of the gems we add depend on env
# variables being available
gem "dotenv-rails"

group :development do
  gem "awesome_print"
  gem "rubocop"
end

group :development, :test do
  # ActiveRecord N+1 detection
  gem "bullet"
  # Call "byebug" anywhere in the code to stop execution and get a debugger
  # console
  gem "byebug"
  # Provides Rails integration for factory_bot. Enables "build_dummy_data"
  # functionality in dev
  # N.B require is false so factories aren"t loaded during e.g db:migrate
  gem "factory_bot_rails"
  # Used to generate fake data e.g. in the specs
  gem "faker"
  gem "rspec-rails"
end

group :test do
  gem "capybara"
  gem "capybara-email"
  gem "ci_reporter_rspec"
  # Needed for headless testing with Javascript or pages that ref external sites
  gem "poltergeist"
  # Tool for checking code coverage
  gem "simplecov", require: false
end

group :production do
  # Use Passenger as our web-server/app-server (e.g. on AWS via Upstart, Heroku
  # via Procfile)
  gem "passenger", "~> 6.0", require: "phusion_passenger/rack_handler"
end
