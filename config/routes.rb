Rails.application.routes.draw do
  
  get "/auth/auth0/callback" => "auth0#callback"
  get "/auth/failure" => "auth0#failure"
  get "/signinalt", to: "users#signinalt"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'coins#index'
  resources :categories
  resources :coins

  match '/coins/edit', to: "coins#edit", via: "post"

  get "/users/show", to: "users#show"

  get "/failure", to: "auth0#failure"

end
