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
    get 'login' => 'devise/sessions#new'
    get 'register' => 'devise/registrations#new'
    get 'profile' => 'devise/registrations#edit'
    delete 'logout' => 'devise/sessions#destroy'
  end

  get '/p/category/:category_id' => 'products#category', :as =>'category_products'
  get '/b/:id' => 'businesses#show', :as => 'business_name'
  get '/p/:business_id/:id' => 'products#show', :as => 'product_name'
  get '/c/:business_id/:id' => 'catalogs#show', :as => 'catalog_name'
  get '/profile'=>'users#show'
  get '/my-businesses' => 'users#businesses', :as => 'user_businesses'
  get '/b/category/:category_id' => 'businesses#category', :as => 'category_business'

  get '/products' => 'products#all', :as => 'products'
  get '/:business_id/:product_id/all_features'=>'features#all', :as => 'features_raw_list'
  get '/:business_id/all_branches'=>'branches#all', :as => 'branches_raw_list'
  get '/:business_id/all_catalogs' => 'catalogs#all', :as => 'catalogs_raw_list'

  get '/report/review/:id' => 'reviews#report', :as => 'report_review'

  get '/search' => 'utils#search', :as => 'search'

  root :to => 'utils#home'


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
      get '*not_found' =>'errors#error_404'
  end
end