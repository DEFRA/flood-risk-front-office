source "https://rubygems.org"
ruby "2.2.3"

gem "rails", "~> 4.2"
gem "pg"
gem "govuk_template", "~> 0.17.0"         # GDS layout into which we inject content using yield and content_for
gem "govuk_frontend_toolkit", "~> 4.9.1"  # Access to some of the most common styles and scripts used by GDS
gem "pundit", "~> 1.1.0"
gem "before_commit"                       # Install overcommits. Required for development and in CI
gem "sass-rails", "~> 5.0"                # Use SCSS for stylesheets
gem "uglifier", ">= 1.3.0"                # Use Uglifier as compressor for JavaScript assets
gem "coffee-rails", "~> 4.1.0"            # Use CoffeeScript for .coffee assets and views
gem "jquery-rails"
gem "turbolinks"                          # Read more: https://github.com/rails/turbolinks

gem "flood_risk_engine",
    git: "https://github.com/EnvironmentAgency/flood-risk-engine",
    branch: "develop"

group :development, :test do
  gem "dotenv-rails" # For loading ENV vars from a .env file in the root
  gem "rspec-rails", "~> 3.4.2"
  gem "byebug" # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "spring" # Spring speeds up development by keeping your application running in the background.
  gem "spring-commands-rspec", require: false # allow spring to wrap the rspec command
  gem "guard", require: false # Guard for auto-execution of specs and live-reload
  gem "guard-rspec", ">= 4.6", require: false
  gem "bullet" # ActiveRecord N+1 detection
  # N.B require is false so factories aren't loaded during e.g db:migrate
  gem "factory_girl_rails", "~> 4.6.0", require: false
  gem "ffaker", "~> 2.2.0"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem "web-console", "~> 2.0"
end

group :test do
  gem "simplecov", "~> 0.11", require: false # Reports on code coverage after specs run
end
