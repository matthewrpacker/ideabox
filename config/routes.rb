Rails.application.routes.draw do

  resources :users, only: [:new, :create, :show] do
    resources :ideas
  end

  namespace :admin do
    resources :categories
  end

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  #make user directory in controller directory with base controller file with
end
