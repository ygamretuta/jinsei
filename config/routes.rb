Jinsei::Application.routes.draw do

  root :to => "businesses#index"
  resources :businesses
end
