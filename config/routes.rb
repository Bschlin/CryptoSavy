Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :v1 do

    post "/users" => "users#create"

    get "/favorites" => "favorites#index"
    post "/favorites" => "favorites#create"
    delete "/favorites/:id" => "favorites#destroy"

    get "/coins" => "coins#index"
    get "/coins/:id" => "coins#show"

    # get "/wallets" => "wallets#index"
    get "/wallets/:id" => "wallets#show"
  end 
end
