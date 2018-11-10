Rails.application.routes.draw do
  resources :posts
  resources :comments
  resources :settings

  root 'posts#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  
  get 'profile', to: 'users#profile'

  get '/403', to: 'application#fourothree'


  # votes
  get '/post/:post_id/upvote', to: 'votes#upvote', format: :js
  get '/post/:post_id/downvote', to: 'votes#downvote', format: :js
  get '/comments/:comment_id/upvote', to: 'votes#upvote', format: :js
  get '/comments/:comment_id/downvote', to: 'votes#downvote',format: :js

  # comments
  post '/comments', to: 'comments#create', format: :js
  delete '/comments/:id', to: 'comments#destroy', format: :js
  get '/post/:post_id/comments/:id/new', to: 'comments#new', format: :js

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
