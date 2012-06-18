Jinsei::Application.routes.draw do
  match '/b/:id', :to => 'businesses#show', :as => 'business_name'
  match '/p/:business_id/:id', :to => 'products#show', :as => 'product_name'
  match '/c/:business_id/:id', :to => 'catalogs#show', :as => 'catalog_name'

  root :to => "businesses#index"

  resources :businesses do
    resources :products

    resources :catalogs do
      resources :products
    end
  end
end
