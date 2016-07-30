Rails.application.routes.draw do

  devise_for :users, class_name: 'FormUser', :controllers => { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'coins#index'
  resources :categories
  resources :coins
  resources :users

  match '/coins/edit', to: "coins#edit", via: "post"

  devise_scope :user do get "/signup" => "devise/registrations#new" end

  match 'googlefa776d738ee14df5.html', to: "users#verify", via: "get"

end
