Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resources :users do
    member do
      get '/users/get_users', to: "users#index", as: :get_Users
      post '/users/add_user', to: "users#addUser", as: :add_User
      delete '/users/delete_user', to: "users#removeUser", as: :delete_User
      get '/users/show_user', to: "users#showUser", as: :show_User
      put '/users/update_user', to: "users#updateUser", as: :update_User
    end
  end

  resources :auth do
    member do
      post 'login', to: "auth#login", as: :login
    end
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
