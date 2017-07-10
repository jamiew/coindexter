Rails.application.routes.draw do

  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations'}, sign_up: 'signup', sign_in: 'login'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'users#index'
  
  resources :categories
  
  resources :users do
    get :following
    get :activity
    resources :subscriptions
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
      member do
        put :follow
        put :unfollow
        get :logs
        get :ico
        get :edit_ico
      end
    end

    resources :links, path: :questions do 
      resources :comments do
        resources :comments
      end
    end

  end

  resources :links, path: :questions do 
    resources :comments do
      resources :comments
    end
  end

  resources :whitepapers

  require 'sidekiq/web'
  
  mount Sidekiq::Web => '/sidekiq'
  
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

  get 'questions', to: 'links#index', :as => :questions

  devise_scope :user do
    get 'signup', to: 'devise/registrations#new'
    get 'signin', to: 'devise/sessions#new'
  end

  get ':username', to: 'users#show', :as => :current_user
  get '/users/:username/subscriptions/new', to: 'subscriptions#new'
  post '/users/:username/subscriptions/checkout', to: 'subscriptions#create'
  
  get ':username/edit', to: 'users#edit', :as => :edit_current_user
  
  get ':username/activity', to: 'users#activity', :as => :current_user_activity

end
