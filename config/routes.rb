Rails.application.routes.draw do
  root to: 'users#index'
  resources :users, only: %i( index show )

  get 'oauth/callback' => 'oauths#callback', as: :oauth_callback
  get 'oauth/:provider' => 'oauths#oauth', as: :oauth_login

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
