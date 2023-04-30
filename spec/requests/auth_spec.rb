# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Auth' do
  describe 'GET auth/signin' do
    it 'returns http success' do
      get '/auth/signin'
      expect(response).to have_http_status(:bad_request)
    end
  end

  describe 'GET auth/signout' do
    it 'returns http redirect' do
      get '/auth/signout'
      expect(response).to have_http_status(:redirect)
    end
  end
end
