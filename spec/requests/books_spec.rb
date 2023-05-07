# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/books' do
  describe 'GET /index' do
    before do
      create(:book)
    end

    it 'renders html a successful response' do
      get books_url
      expect(response).to be_successful
    end

    it 'renders json a successful response' do
      get books_url.concat('.json')
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    let(:book) { create(:book) }

    it 'renders html a successful response' do
      get book_url(book)
      expect(response).to be_successful
    end

    it 'renders json a successful response' do
      get book_url(book).concat('.json')
      expect(response).to be_successful
    end
  end
end
