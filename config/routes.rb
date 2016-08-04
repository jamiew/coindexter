Rails.application.routes.draw do

  devise_for :users, class_name: 'FormUser', :controllers => { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  match '/coins/marketcap', to: "coins#sorted_by_market_cap", via: "get"

  root 'coins#index'
  resources :categories
  resources :coins
  resources :users
  resources :searches
  resources :links

  match '/search', to:"searches#results", via: "get"

  match '/coins/edit', to: "coins#edit", via: "post"

  devise_scope :user do get "/signup" => "devise/registrations#new" end

end
