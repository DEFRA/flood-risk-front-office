# rubocop:disable Metrics/LineLength
source "https://rubygems.org"
ruby "2.3.1"

gem "flood_risk_engine",
    git: "https://github.com/EnvironmentAgency/flood-risk-engine",
    branch: "feature/RIP_143_check_answers_change_link"
# tag: "v1.0.0" replaced :Tag with a :branch in order to test https://github.com/EnvironmentAgency/flood-risk-engine/pull/241

gem "rails", "4.2.7"
gem "pg", "~> 0.18.4"
gem "govuk_template", "~> 0.17.0" # GDS layout into which we inject content using yield and content_for
gem "govuk_frontend_toolkit", "~> 4.12.0" # Access to some of the most common styles and scripts used by GDS
gem "govuk_elements_rails", "~> 1.2.1"
gem "pundit", "~> 1.1.0"
gem "high_voltage", "~> 3.0.0" # Rails engine for static pages. https://github.com/thoughtbot/high_voltage NB declaring this in the engine does not seem to work, for example the routes do not appear
gem "dotenv-rails", "~> 2.1"
gem "sass-rails", "~> 5.0.4" # Use SCSS for stylesheets
gem "uglifier", ">= 1.3.0" # Use Uglifier as compressor for JavaScript assets
gem "jquery-rails", "~> 4.1.1" # Use jquery as the JavaScript library
gem "whenever", "~> 0.9.4", require: false # Our capistrano scripts expect whenever (for scheduling cron jobs) to be available

group :development, :test do
  gem "puma" # Replacement for webrick in development
  gem "rspec-rails", "~> 3.4.2"
  gem "byebug" # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "bullet" # ActiveRecord N+1 detection
  gem "factory_girl_rails", "~> 4.6.0", require: false # N.B require is false so factories aren't loaded during e.g db:migrate
  gem "faker", "~> 1.6.5"
  gem "before_commit", "~> 0.8"
  gem "quiet_assets", "~> 1.1"
end

group :test do
  gem "capybara", "~> 2.6.2"
  gem "poltergeist", "~> 1.9.0" # Needed for headless testing with Javascript or pages that ref external sites
  gem "capybara-email", "~> 2.5.0"
  gem "simplecov", "~> 0.11.2", require: false # Tool for checking code coverage
  gem "ci_reporter_rspec", "~> 1.0.0", require: false
  gem "codeclimate-test-reporter", "~> 0.5.2", require: false # Allow test coverage to be reported for codeclimate for displaying in the readme
end

group :development do
  gem "web-console", "~> 2.0" # Access an IRB console on exception pages or by using <%= console %> in views
  gem "rack-mini-profiler", "~> 0.10" # Displays view/sql rendering times in development, top left in browser
end

group :production do
  gem "rails_12factor", "~> 0.0.3" # Required for Heroku - can be removed when Heroku apps decommissioned
  gem "passenger", "~> 5.0.28", require: "phusion_passenger/rack_handler" # Use Passenger as our web-server/app-server (e.g. on AWS via Upstart, Heroku via Procfile)
  gem "airbrake", "~> 5.3.0" # Airbrake catches exceptions, sends them to https://dst-errbit.herokuapp.com
end
