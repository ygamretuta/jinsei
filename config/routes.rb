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

  match '/b/:id', :to => 'businesses#show', :as => 'business_name'
  match '/p/:business_id/:id', :to => 'products#show', :as => 'product_name'
  match '/c/:business_id/:id', :to => 'catalogs#show', :as => 'catalog_name'
  match '/profile', :to=>'users#show'
  match '/my-businesses', :to => 'users#businesses', :as => 'user_businesses'
  match '/category/:category_id', :to => 'products#category', :as =>'category_products'
  match '/products', :to => 'products#all', :as => 'products'

  root :to => "businesses#index"


  resources :businesses do
    resources :products

    resources :catalogs do
      resources :products
    end
  end
end
