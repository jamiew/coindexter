Rails.application.routes.draw do

  devise_for :users, class_name: 'FormUser', :controllers => { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'coins#index'
  resources :categories
  resources :coins
  resources :users
  resources :searches
  resources :networks
  resources :links do
    resources :comments
  end
  resources :comments do
    resources :comments
  end

  match '/networks/:id/links', to:'networks#links', via: 'get'
  match '/networks/:id/trollbox', to:'networks#trollbox', via: 'get'
  match '/networks/:id/log', to:'networks#log', via: 'get'

  match '/coins/:id/links', to:'coins#links', via: 'get'
  match '/coins/:id/trollbox', to:'coins#trollbox', via: 'get'
  match '/coins/:id/log', to:'coins#log', via: 'get'

  match '/search', to:"searches#results", via: "get"

  match '/coins/edit', to: "coins#edit", via: "post"

  devise_scope :user do get "/signup" => "devise/registrations#new" end

end
