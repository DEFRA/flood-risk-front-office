source "https://rubygems.org"
ruby "3.2.2"

gem "defra_ruby_template", "~> 5.11"
gem "faraday"
gem "faraday-retry"
gem "govuk_design_system_formbuilder"
gem "high_voltage"
gem "jquery-rails", "~> 4.4"
gem "net-imap", require: false
gem "net-pop", require: false
gem "pg"
gem "pundit"
gem "sass-rails"
gem "secure_headers"
gem "terser"
gem "whenever"

gem "flood_risk_engine",
    git: "https://github.com/DEFRA/flood-risk-engine",
    branch: "main"

# This is specified in the engine gemspec,
# but need to specify here also to pick up i18n locales
# Pin to below v3 to avoid pulling in the companies house gem
gem "defra_ruby_validators", "~> 2.7"

gem "github_changelog_generator", require: false

# Automatically loads environment variables from .env into ENV. Specified here
# rather than in the group in case any of the gems we add depend on env
# variables being available
gem "dotenv-rails"

group :development do
  gem "awesome_print"
  gem "defra_ruby_style"
  gem "webrick"
end

group :development, :test do
  # ActiveRecord N+1 detection
  gem "bullet"
  # Call "byebug" anywhere in the code to stop execution and get a debugger
  # console
  gem "byebug"
  # Provides Rails integration for factory_bot. Enables "build_dummy_data"
  # functionality in dev
  gem "factory_bot_rails"
  # Used to generate fake data e.g. in the specs
  gem "faker"
  gem "rspec-rails"

  gem "rubocop"
  gem "rubocop-capybara"
  gem "rubocop-rails"
  gem "rubocop-rspec"
  gem "rubocop-rspec_rails"
end

group :test do
  gem "capybara"
  gem "capybara-email"
  gem "ci_reporter_rspec"
  # Needed for headless testing with Javascript or pages that ref external sites
  gem "poltergeist"
  # Tool for checking code coverage, version pinned to support Sonarcloud
  gem "simplecov", "~> 0.17.1", require: false
end

# Pin this version as well as passenger to avoid https://github.com/phusion/passenger/issues/2508
gem "rack", "~> 2.2"

group :production do
  # Use Passenger as our web-server/app-server (e.g. on AWS via Upstart, Heroku
  # via Procfile)
  # Pin this version as well as rack to avoid https://github.com/phusion/passenger/issues/2508
  gem "passenger", "6.0.19", require: "phusion_passenger/rack_handler"
end

gem "nokogiri", "~> 1.16"
