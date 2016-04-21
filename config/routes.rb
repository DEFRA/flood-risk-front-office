Rails.application.routes.draw do

  mount DatashiftState::Engine => "/datashift_state"

  get '/shift_state/journey_plans/:state/:id', :to => 'datashift_state/journey_plans#update'
  get '/shift_state/journey_plans/:id', :to => 'datashift_state/journey_plans#update'

  root 'datashift_state/journey_plans#new'

  #root to: "enrollments#new"
end
