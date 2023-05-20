# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'dashboard#show'

  get 'auth/cognito-idp/callback', to: 'cognito_idp#callback'

  direct :cognito_logout do
    query = {
      client_id: ENV.fetch('AWS_COGNITO_APP_CLIENT_ID', nil),
      logout_uri: root_url
    }.to_param
    "#{ENV.fetch('AWS_COGNITO_POOL_SITE', nil)}/logout?#{query}"
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources :books, only: %i[index show] do
    resources :bookcases, only: [] do
      resource :book_in_bookcase, controller: 'books/bookcases/book_in_bookcase', only: %i[create destroy]
    end
  end

  resources :users, param: :name, only: %i[index show], path: '/' do
    resources :bookcases, controller: 'users/bookcases' do
      resources :book_in_bookcases, controller: 'users/bookcases/book_in_bookcases', only: %i[show destroy]
    end
  end
end
