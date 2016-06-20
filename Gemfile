# rubocop:disable Metrics/LineLength
source "https://rubygems.org"
ruby "2.3.1"

gem "flood_risk_engine",
    git: "https://github.com/EnvironmentAgency/flood-risk-engine",
    branch: "develop"

gem "rails", "~> 4.2"
gem "pg", "~> 0.18.4"
gem "govuk_template", "~> 0.17.0" # GDS layout into which we inject content using yield and content_for
gem "govuk_frontend_toolkit", "~> 4.12.0" # Access to some of the most common styles and scripts used by GDS
gem "govuk_elements_rails", "~> 1.2.1"
gem "pundit", "~> 1.1.0"
gem "high_voltage", "~> 3.0" # Rails engine for static pages. https://github.com/thoughtbot/high_voltage NB declaring this in the engine does not seem to work, for example the routes do not appear
gem "dotenv-rails", "~> 2.1"
gem "sass-rails", "~> 5.0" # Use SCSS for stylesheets
gem "uglifier", ">= 1.3.0" # Use Uglifier as compressor for JavaScript assets
gem "jquery-rails" # Use jquery as the JavaScript library
gem "whenever", "~> 0.9.4", require: false # Our capistrano scripts expect whenever (for scheduling cron jobs) to be available

group :development, :test do
  gem "puma" # Replacement for webrick in development
  gem "rspec-rails", "~> 3.4.2"
  gem "byebug" # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "bullet" # ActiveRecord N+1 detection
  gem "factory_girl_rails", "~> 4.6.0", require: false # N.B require is false so factories aren't loaded during e.g db:migrate
  gem "faker"
  gem "before_commit", "~> 0.6"
  gem "quiet_assets", "~> 1.1"
end

group :test do
  gem "capybara", "~> 2.6.2"
  gem "poltergeist", "~> 1.9.0" # Needed for headless testing with Javascript or pages that ref external sites
  gem "selenium-webdriver", "~> 2.53.0"
  gem "chromedriver-helper", "1.0.0"
  gem "capybara-email", "~> 2.5.0"
  gem "launchy", require: false # save_and_open_page
  gem "shoulda-matchers", "~> 3.1.1", require: false
  gem "database_cleaner", "~> 1.5.1"
  gem "vcr", "~> 3.0.1"
  gem "webmock", "~> 1.24.2"
  gem "simplecov", "~> 0.11", require: false # Tool for checking code coverage
  gem "ci_reporter_rspec", "~> 1.0.0", require: false # Enables generation of reports so test coerage displayed in readme
end

group :development do
  gem "web-console", "~> 2.0" # Access an IRB console on exception pages or by using <%= console %> in views
  gem "rack-mini-profiler", "~> 0.10" # Displays view/sql rendering times in development, top left in browser
end

group :production do
  gem "rails_12factor" # Required for Heroku - can be removed when Heroku apps decommissioned
  gem "passenger", "~> 5.0.28", require: "phusion_passenger/rack_handler" # Use Passenger as our web-server/app-server (e.g. on AWS via Upstart, Heroku via Procfile)
end
