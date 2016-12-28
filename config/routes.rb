Rails.application.routes.draw do

  devise_for :users, class_name: 'FormUser', :controllers => { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations'}, sign_up: 'signup'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'users#index'
  resources :categories
  resources :users do
    member do
      get :confirm_email
    end
  end

  resources :coins

  resources :links do 
    resources :comments do
      resources :comments
    end
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

  resources :whitepapers

  match 'networks/:network_id/coins/:id/logs', to:'coins#logs', via: 'get'
  
  match 'networks/:id/logs', to:'networks#logs', via: 'get'


  match '/search', to:"searches#results", via: "get"

  match '/account/', to:"users#edit", via: "get"
  
  match '/account/:id', to:"users#edit", via: "get"

  match '/about', to:'application#about', via: 'get'

  match 'finish/:id/', to: 'users#finish', :as => :finish, via: "get"

  devise_scope :user do
    get 'signup', to: 'devise/registrations#new'
    get 'signin', to: 'devise/sessions#new'
  end

  match ':id/', to: 'users#show', via: "get"

end
