# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#show'

  get '/signin', to: 'session#signin'
  get '/signout', to: 'session#signout'
  get '/signup', to: 'session#signup'

  get 'auth/signin'
  get 'auth/signout'
end
