# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'dashboard#show'

  get '/signin', to: 'session#signin'
  get '/signout', to: 'session#signout'
  get '/signup', to: 'session#signup'

  get 'auth/signin'
  get 'auth/signout'

  resources :users, param: :name, only: [:show], path: '/' do
    resources :bookcases
  end
end
