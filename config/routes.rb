# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'dashboard#show'

  get '/signin', to: 'session#signin'
  get '/signout', to: 'session#signout'
  get '/signup', to: 'session#signup'

  get 'auth/signin'
  get 'auth/signout'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources :books, only: %i[index show] do
    resources :bookcases, only: [] do
      resource :book_in_bookcase, controller: 'books/bookcases/book_in_bookcase', only: %i[create destroy]
    end
  end

  resources :users, param: :name, only: [:show], path: '/' do
    resources :bookcases, controller: 'users/bookcases' do
      resources :book_in_bookcases, controller: 'users/bookcases/book_in_bookcases', only: %i[show destroy]
    end
  end
end
