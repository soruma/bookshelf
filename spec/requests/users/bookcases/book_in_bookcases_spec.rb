# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/:user_name/bookcases/:bookcase_id/book_in_bookcases' do
  describe 'GET /show' do
    let(:bookcase) do
      create(:bookcase, user: create(:user))
    end

    let(:book_in_bookcase) do
      create(:book_in_bookcase, bookcase:)
    end

    it 'renders html a successful response' do
      get user_bookcase_book_in_bookcase_url(bookcase.user.name, bookcase, book_in_bookcase)
      expect(response).to be_successful
    end

    it 'renders json a successful response' do
      get user_bookcase_book_in_bookcase_url(bookcase.user.name, bookcase, book_in_bookcase).concat('.json')
      expect(response).to be_successful
    end
  end
end
