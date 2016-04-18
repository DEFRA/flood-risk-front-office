Rails.application.routes.draw do
  mount FloodRiskEngine::Engine => '/fre'

  # Root currently defined as a Static page  - defined in config/initializers/high_voltage.rb
  # This is a Temporary Measure for show and tell etc - The real home page will be hosted on gov uk
  # and eventually point to our real root
  #
  # root to: "flood_risk_engine/enrollments#new"

end
