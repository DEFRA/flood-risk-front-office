require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FloodRiskFrontOffice
  class Application < Rails::Application
    config.autoload_paths += Dir["#{config.root}/lib/**/"]

    config.to_prepare do
      Dir.glob(File.join(Rails.root, 'app/decorators', '**/*_decorator*.rb')).each do |c|
        require_dependency(c)
      end
    end

    config.to_prepare do
      Dir.glob(File.join(Rails.root, 'app/policies', '**/*.rb')).each do |c|
        require_dependency(c)
      end
    end

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    config.time_zone = 'London'

    # Fix sass compilation error in govuk_frontend:
    # SassC::SyntaxError: Error: "calc(0px)" is not a number for `max'
    # https://github.com/alphagov/govuk-frontend/issues/1350
    config.assets.css_compressor = nil

    # For Rails 7: https://guides.rubyonrails.org/active_record_multiple_databases.html#migrate-to-the-new-connection-handling
    config.active_record.legacy_connection_handling = false
  end
end
