Rails.application.routes.draw do

  resources :whitepapers
  devise_for :users, class_name: 'FormUser', :controllers => { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations', confirmations: 'confirmations'}, sign_up: 'signup'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'users#index'
  resources :categories
  resources :coins
  resources :users do
    member do
      get :confirm_email
    end
  end

  resources :searches
  resources :networks do
    resources :whitepapers, :coins
  end
  resources :links do
    resources :comments
  end
  resources :comments do
    resources :comments
  end

  match '/networks/:id/links', to:'networks#links', via: 'get'
  match '/networks/:id/trollbox', to:'networks#trollbox', via: 'get'
  match '/networks/:id/logs', to:'networks#logs', via: 'get'
  match '/networks/:id/whitepapers', to:'networks#whitepapers', via: 'get'

  match '/coins/:id/links', to:'coins#links', via: 'get'
  match '/coins/:id/trollbox', to:'coins#trollbox', via: 'get'
  match '/coins/:id/logs', to:'coins#logs', via: 'get'

  match '/search', to:"searches#results", via: "get"

  match '/account/', to:"users#edit", via: "get"

  match '/account/:id', to:"users#edit", via: "get"

  match '/about', to:'application#about', via: 'get'

  match 'finish/:id/', to: 'users#finish', :as => :finish, via: "get"

  match ':id/', to: 'users#show', via: "get"

  devise_scope :user do
    get 'signup', to: 'devise/registrations#new'
    get 'signin', to: 'devise/sessions#new'
  end



end
