
Rails.application.routes.draw do

  devise_for :users
  root to: "users#index"

  namespace :posts do
    resources :searches, only: [:index]
  end
  
  resources :comments, only: [:index,:create,:update] do
    resources :answers, only: [:new,:create] 
  end
  resources :users, only: [:show]
  resources :posts, except: [:index,:show]
  resources :tags, only: [:index,:show]

end
