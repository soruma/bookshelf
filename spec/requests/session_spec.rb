# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Session' do
  describe 'GET /signin' do
    it 'returns http redirect' do
      get '/signin'
      expect(response).to have_http_status(:redirect)
    end
  end

  describe 'GET /signout' do
    it 'returns http redirect' do
      get '/signout'
      expect(response).to have_http_status(:redirect)
    end
  end

  describe 'GET /signup' do
    it 'returns http redirect' do
      get '/signup'
      expect(response).to have_http_status(:redirect)
    end
  end
end
