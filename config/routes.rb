Rails.application.routes.draw do


  resources :songs

  resources :users do
    resources :playlists
  end

end
