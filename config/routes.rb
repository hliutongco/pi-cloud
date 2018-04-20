Rails.application.routes.draw do

  root to: "home#index"

  # get "/reset", to: "password_resets#new", as: "prompt_email_reset"
  # get "/reset_password", to: "password_resets#create", as: "reset_password"
  # get '/new_password', to: "password_resets#edit", as: 'new_password'

  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :account_activations, only: [:edit]
  
  get "/signup", to: "users#new", as: "signup"
  get "/login", to: "sessions#new", as: "login"
  post "/login", to: "sessions#create", as: "sessions"
  post "/logout", to: "sessions#logout", as: "logout"
  get "/users/feed" => "users#feed"
  get "/users/:id/followers" => "users#followers"
  get "/users/:id/following" => "users#following"

  post "/users/:user_id/songs/:id/add_song", to: "songs#add_to_playlist", as: "add_playlist_song"
  post "/users/:user_id/playlists/:id/remove_song", to: "playlists#remove_song", as: "remove_playlist_song"



  resources :users do
    resources :songs do
      resources :song_comments
    end
    resources :playlists do
      resources :playlist_comments
    end
  end

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :relationships, only: [:create, :destroy]

end
