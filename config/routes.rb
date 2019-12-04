Rails.application.routes.draw do
  root to: 'toppages#tops'

  resources :tasks

  resources :users, only: %i[new create show]

  resources :sessions, only: %i[new create destroy]

  namespace :admin do
    resources :users
  end

  resources :groups

  resources :joins, only: %i[create destroy]
end
