Rails.application.routes.draw do

  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations'}, sign_up: 'signup', sign_in: 'login'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'networks#index'
  resources :categories
  resources :users do
  end

  resources :coins

  resources :comments do
    resources :comments
  end

  resources :searches
  resources :networks do
    resources :whitepapers, :coins
    resources :links do 
      resources :comments do
        resources :comments
      end
    end

  end

  resources :links do 
    resources :comments do
      resources :comments
    end
  end

  resources :whitepapers

  match 'networks/:network_id/coins/:id/logs', to:'coins#logs', via: 'get'

  match 'links', to: 'links#index_all', :as => 'all_links', via: 'get'
  
  match 'networks/:id/logs', to:'networks#logs', via: 'get'

  match '/search', to:"searches#results", via: "get"

  match '/account/', to:"users#edit", via: "get"
  
  match '/account/:id', to:"users#edit", via: "get"

  match 'finish/:id/', to: 'users#finish', :as => :finish, via: "get"

  match 'about', to: 'users#index', :as => :about, via: "get"

  match 'sales', to: 'coins#sales', :as => :sales, via: "get"

  get :coin_search, to: 'searches#coin_search', :as => :coin_search

  get :network_search, to: 'searches#network_search', :as => :network_search

  get :network_match, to: 'searches#network_match', :as => :network_match

  get 'networks/:network_id/coin/:id/add_network', to: 'coins#add_network', :as => :add_network_to_coin

  devise_scope :user do
     get 'signup', to: 'devise/registrations#new'
     get 'signin', to: 'devise/sessions#new'
  end

  match ':id/', to: 'users#show', via: "get"

end
