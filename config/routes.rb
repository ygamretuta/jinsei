Jinsei::Application.routes.draw do
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
  match '/products', :to => 'products#all', :as => 'products'
  match '/:business_id/:product_id/all_features', :to=>'features#all', :as => 'features_raw_list'
  match '/:business_id/:product_id/pending_reviews', :to => 'reviews#pending_product', :as => 'reviews_pending_product'
  match '/:business_id/all_branches', :to=>'branches#all', :as => 'branches_raw_list'

  root :to => "businesses#index"


  resources :businesses do
    resources :branches, :except => [:show]
    resources :reviews

    resources :products do
      resources :reviews
      resources :features
    end

    resources :catalogs do
      resources :products
    end
  end
end