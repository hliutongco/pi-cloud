Rails.application.routes.draw do

  get "signup", to: "users#new", as: "signup"
  get "login", to: "sessions#new", as: "login"
  post "login", to: "sessions#create", as: "sessions"

  resources :users do
    resources :songs
    resources :playlists
  end

end
