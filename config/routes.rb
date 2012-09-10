Jinsei::Application.routes.draw do

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users, :controllers => {
      :omniauth_callbacks => 'users/omniauth_callbacks'
  },
  :path_names => {
      :sign_up => 'register',
      :sign_in => 'login',
      :sign_out => 'logout',
      :profile => 'profile'
  }

  devise_scope :user do
    get 'login', :to => 'devise/sessions#new'
    get 'register', :to => 'devise/registrations#new'
    get 'profile', :to => 'devise/registrations#edit'
    delete 'logout', :to => 'devise/sessions#destroy'
  end

  match '/p/category/:category_id', :to => 'products#category', :as =>'category_products'
  match '/b/:id', :to => 'businesses#show', :as => 'business_name'
  match '/p/:business_id/:id', :to => 'products#show', :as => 'product_name'
  match '/c/:business_id/:id', :to => 'catalogs#show', :as => 'catalog_name'
  match '/profile', :to=>'users#show'
  match '/my-businesses', :to => 'users#businesses', :as => 'user_businesses'
  match '/b/category/:category_id', :to => 'businesses#category', :as => 'category_business'
  match '/:business_id/:product_id/pending_reviews', :to => 'reviews#pending_product', :as => 'reviews_pending_product'

  match '/products', :to => 'products#all', :as => 'products'
  match '/:business_id/:product_id/all_features', :to=>'features#all', :as => 'features_raw_list'
  match '/:business_id/all_branches', :to=>'branches#all', :as => 'branches_raw_list'
  match '/:business_id/all_catalogs', :to => 'catalogs#all', :as => 'catalogs_raw_list'

  match '/search', :to => 'utils#search', :as => 'search'

  root :to => "utils#home"


  resources :businesses do
    resources :branches, :except => [:show]
    resources :reviews, :except => [:show]

    resources :products do
      resources :reviews
      resources :features
    end

    resources :catalogs do
      resources :products
    end
  end

  unless Rails.application.config.consider_all_requests_local
      match '*not_found', to: 'errors#error_404'
  end
end