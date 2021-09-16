Rails.application.routes.draw do
  mount FloodRiskEngine::Engine => "/"

  root to: "flood_risk_engine/start_forms#new"

  resource :cookies, only: [:update] do
    member do
      post :accept_analytics
      post :reject_analytics
      post :hide_this_message
    end
  end
end
