Rails.application.routes.draw do
  resources :posts
  resources :settings

  root 'posts#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  
  get 'profile', to: 'users#profile'

  get '/403', to: 'application#fourothree'


  # votes
  get '/votes/:id/upvote',   to: 'votes#upvote',   format: :js
  get '/votes/:id/downvote', to: 'votes#downvote', format: :js
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
