source "https://rubygems.org"
ruby "2.3.1"

# Automatically loads environment variables from .env into ENV. Specified here
# rather than in the group in case any of the gems we add depend on env
# variables being available
gem "dotenv-rails", "~> 2.1"

gem "flood_risk_engine",
    git: "https://github.com/EnvironmentAgency/flood-risk-engine",
    tag: "v1.0.1"

gem "govuk_elements_rails", "~> 1.2.1"
# Access to some of the most common styles and scripts used by GDS
gem "govuk_frontend_toolkit", "~> 4.12.0"
# GDS layout into which we inject content using yield and content_for
gem "govuk_template", "~> 0.17.0"
# Rails engine for static pages. https://github.com/thoughtbot/high_voltage
# NB declaring this in the engine does not seem to work, for example the routes
# do not appear
gem "high_voltage", "~> 3.0.0"
# Use jquery as the JavaScript library
gem "jquery-rails", "~> 4.1.1"
# Use Postgres for the DB
gem "pg", "~> 0.18.4"
gem "pundit", "~> 1.1.0"
gem "rails", "4.2.7.1"

# Use SCSS for stylesheets
gem "sass-rails", "~> 5.0.4"
# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"
# Our capistrano scripts expect whenever (for scheduling cron jobs) to be
# available
gem "whenever", "~> 0.9.4", require: false

group :development, :test do
  # ActiveRecord N+1 detection
  gem "bullet"
  # Call 'byebug' anywhere in the code to stop execution and get a debugger
  # console
  gem "byebug"
  # N.B require is false so factories aren't loaded during e.g db:migrate
  gem "factory_girl_rails", "~> 4.6.0", require: false
  gem "faker", "~> 1.6.5"
  # Replacement for webrick in development
  gem "puma"
  # Mutes assets pipeline log messages
  gem "quiet_assets", "~> 1.1"
  gem "rspec-rails", "~> 3.4.2"
  # Ensure we are meeting agreed style and consistency rules in the project
  gem "rubocop", "~> 0.45.0"
end

group :test do
  gem "capybara", "~> 2.6.2"
  gem "capybara-email", "~> 2.5.0"
  gem "ci_reporter_rspec", "~> 1.0.0", require: false
  # Allow test coverage to be reported for codeclimate for displaying in the readme
  gem "codeclimate-test-reporter", "~> 0.5.2", require: false
  # Needed for headless testing with Javascript or pages that ref external sites
  gem "poltergeist", "~> 1.9.0"
  # Tool for checking code coverage
  gem "simplecov", "~> 0.11.2", require: false
end

group :development do
  # Displays view/sql rendering times in development, top left in browser
  gem "rack-mini-profiler", "~> 0.10"
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem "web-console", "~> 2.0"
end

group :production do
  # Airbrake catches exceptions, sends them to an Errbit server (we have
  # separate ones for production and non-production environments)
  gem "airbrake", "~> 5.3.0"
  # Use Passenger as our web-server/app-server (e.g. on AWS via Upstart, Heroku
  # via Procfile)
  gem "passenger", "~> 5.0.28", require: "phusion_passenger/rack_handler"
  # Required for Heroku - can be removed when Heroku apps decommissioned
  gem "rails_12factor", "~> 0.0.3"
end
