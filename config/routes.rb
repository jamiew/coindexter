Rails.application.routes.draw do

  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations'}, sign_up: 'signup', sign_in: 'login'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'networks#index'
  resources :categories
  resources :users do
    get :following
    get :activity
  end

  resources :coins do
    member do
      put :follow
      put :unfollow
      get :logs
    end
  end

  resources :comments do
    resources :comments
  end

  resources :searches
  resources :networks do
    member do
      put :follow
      put :unfollow
      get :logs
    end
    resources :whitepapers
    resources :coins do
      get :logs
    end
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
  
  get '/account/', to:"users#edit"
  
  get '/account/:id', to:"users#edit"

  get 'finish/:id/', to: 'users#finish', :as => :finish

  get 'about', to: 'users#index', :as => :about

  get 'sales', to: 'coins#sales', :as => :sales

  get 'search', to: 'searches#results', :as => :results

  get 'coin_search', to: 'searches#coin_search', :as => :coin_search

  get 'network_search', to: 'searches#network_search', :as => :network_search

  get 'network_match', to: 'searches#network_match', :as => :network_match

  get 'networks/:network_id/coin/:id/add_network', to: 'coins#add_network', :as => :add_network_to_coin

  get 'daily_digest', to: 'users#daily_digest', :as => :daily_digest
  
  get ':username', to: 'users#show', :as => :current_user
  
  get ':username/edit', to: 'users#edit', :as => :edit_current_user
  
  get ':username/activity', to: 'users#activity', :as => :current_user_activity


  devise_scope :user do
     get 'signup', to: 'devise/registrations#new'
     get 'signin', to: 'devise/sessions#new'
  end

end
