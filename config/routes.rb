# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'dashboard#show'

  get '/signin', to: 'session#signin'
  get '/signout', to: 'session#signout'
  get '/signup', to: 'session#signup'

  get 'auth/signin'
  get 'auth/signout'

  resources :books, only: %i[index show]

  resources :users, param: :name, only: [:show], path: '/' do
    resources :bookcases, controller: 'users/bookcases' do
      resources :book_in_bookcases, controller: 'users/bookcases/book_in_bookcases', only: [:show]
    end
  end
end
