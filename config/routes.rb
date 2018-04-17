Rails.application.routes.draw do




  resources :users do
    resources :songs
    resources :playlists
  end

end
