source "https://rubygems.org"
ruby "2.3.1"

gem "flood_risk_engine",
    git: "https://github.com/EnvironmentAgency/flood-risk-engine",
    branch: "develop"

gem "copy_kit",
    git: "https://github.com/EnvironmentAgency/copykit",
    branch: "master"

gem "pg"
gem "reform"
gem "reform-rails"

gem "govuk_template", "~> 0.17.0"        # GDS layout into which we inject content using yield and content_for
gem "govuk_frontend_toolkit", "~> 4.9.1" # Access to some of the most common styles and scripts used by GDS

gem "pundit", "~> 1.1.0"

# declaring this in the engine does not seem to work, for example the routes do not appear
gem "high_voltage", "~> 3.0" # Rails engine for static pages. https://github.com/thoughtbot/high_voltage

gem "dotenv-rails", "~> 2.1"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 4.2"

# Use SCSS for stylesheets
gem "sass-rails", "~> 5.0"
# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"
# Use CoffeeScript for .coffee assets and views
gem "coffee-rails", "~> 4.1.0"
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem "jquery-rails"
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem "turbolinks"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.0"
# bundle exec rake doc:rails generates the API under doc/api.
gem "sdoc", "~> 0.4.0", group: :doc
# Our capistrano scripts expect whenever (for scheduling cron jobs) to be available
gem "whenever", "~> 0.9.4", require: false

group :development, :test do
  gem "puma" # Replacement for webrick in development
  gem "rspec-rails", "~> 3.4.2"
  gem "byebug" # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "spring" # Spring speeds up development by keeping your application
  # running in the background. Read more: https://github.com/rails/spring
  gem "spring-commands-rspec", require: false # allow spring to wrap the rspec command
  gem "guard", require: false # Guard for auto-execution of specs and live-reload
  gem "guard-rspec", ">= 4.6", require: false
  gem "bullet" # ActiveRecord N+1 detection

  # N.B require is false so factories aren't loaded during e.g db:migrate
  gem "factory_girl_rails", "~> 4.6.0", require: false
  gem "faker"
  gem "before_commit", "~> 0.6"
  gem "quiet_assets", "~> 1.1"
end

group :test do
  gem "capybara", "~> 2.6.2"
  gem "poltergeist", "~> 1.9.0" # Needed for headless testing with Javascript or pages that ref external sites
  gem "capybara-email", "~> 2.5.0"
  gem "launchy", require: false # save_and_open_page
  gem "shoulda-matchers", "~> 3.1.1", require: false
  gem "database_cleaner", "~> 1.5.1"
  gem "fuubar" # Enhanced rspec progress formatter
  gem "vcr", "~> 3.0.1"
  gem "webmock", "~> 1.24.2"
  gem "test_after_commit", "~> 1.0.0" # Make after_commit callbacks fire in tests with transactional_fixtures = true
  gem "selenium-webdriver", "~> 2.53.0"
  gem "chromedriver-helper", "1.0.0"
  gem "stackprof"

  # Enables generation of JUnit compatible xml report files when rspec is run
  gem "ci_reporter_rspec", "~> 1.0.0", require: false

  # which can then be viewed and reported on by Jenkins
  gem "simplecov", "~> 0.11", require: false # Tool for checking code coverage
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem "web-console", "~> 2.0"
end

group :production do
  gem "rails_12factor" # Required for Heroku - can be removed when Heroku apps decommissioned
  # Use Passenger as our web-server/app-server
  # (e.g. on AWS via Upstart, Heroku via Procfile)
  gem "passenger", "~> 5.0.28", require: "phusion_passenger/rack_handler"
end
