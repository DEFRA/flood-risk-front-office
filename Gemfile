source 'https://rubygems.org'
ruby "2.2.3"

# Once the development stable we should move this to the gemspec
#gem 'digital_services_core', '1.0.0', tag: 'v1.0.0',
#    git: 'https://github.com/EnvironmentAgency/digital-services-core'

gem 'datashift_state', path: '../datashift_state'
#git: 'https://github.com/autotelik/datashift_state'

gem 'flood_risk_engine', path: '../flood-risk-engine'
#git: 'https://github.com/EnvironmentAgency/flood-risk-engine', branch: 'develop'

gem 'pg'
gem 'reform'
gem "reform-rails"

gem "govuk_template", "~> 0.17.0"        # GDS layout into which we inject content using yield and content_for
gem "govuk_frontend_toolkit", "~> 4.9.1" # Access to some of the most common styles and scripts used by GDS

gem "pundit", "~> 1.1.0"

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails', '~> 3.4.2'
  gem 'byebug' # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'spring' # Spring speeds up development by keeping your application
  # running in the background. Read more: https://github.com/rails/spring
  gem 'spring-commands-rspec', require: false # allow spring to wrap the rspec command
  gem 'guard', require: false # Guard for auto-execution of specs and live-reload
  gem 'guard-rspec', '>= 4.6', require: false
  gem 'bullet' # ActiveRecord N+1 detection
  gem 'factory_girl_rails', '~> 4.6.0', require: false # N.B require is false so factories aren't loaded during e.g db:migrate
  gem 'ffaker', '~> 2.2.0'
  gem "database_cleaner", "~> 1.5"

  gem 'dotenv-rails', '~> 2.1'
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', "~> 4.2"

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc



group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
end

