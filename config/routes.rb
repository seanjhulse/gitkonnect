Rails.application.routes.draw do
  resources :posts
  resources :settings

  root 'posts#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  
  get 'profile', to: 'users#profile'

  get '/403', to: 'application#fourothree'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
