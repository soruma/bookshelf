# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users' do
  describe 'GET /:name' do
    before do
      create(:user, name: 'test_user')
    end

    it 'returns http success if record exists' do
      get '/test_user/'
      expect(response).to have_http_status(:success)
    end

    it 'returns http success if not record exists' do
      expect do
        get '/notfound/'
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
