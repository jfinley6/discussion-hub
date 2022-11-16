Rails.application.routes.draw do
  devise_for :accounts
  get "/u/:username", to: 'public#profile', as: :profile
  
  resources :communities do
    resources :posts
  end

  resources :subscriptions, except: :destroy
  delete '/subscriptions/:community_id', to: 'subscriptions#destroy'

  resources :comments, only: [:create, :destroy]

  post '/posts/vote', to: 'votes#create' 

  root to: 'public#index'
  
end
