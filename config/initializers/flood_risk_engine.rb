FloodRiskEngine.configure do |config|
  config.redirection_url_on_location_unchecked = "/pages/contact_ea_location"
end

FloodRiskEngine::ApplicationController.layout 'application'
