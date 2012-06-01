Jinsei::Application.routes.draw do

  match '/b/:name', :to => 'businesses#show', :as => 'business_name'

  root :to => "businesses#index"
  resources :businesses
end
