# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/:user_name/bookcases/:bookcase_id/book_in_bookcases' do
  let(:owner) do
    create(:user)
  end

  let(:other_owner) do
    create(:user)
  end

  let(:bookcase) do
    create(:bookcase, user: owner)
  end

  let(:book_in_bookcase) do
    create(:book_in_bookcase, bookcase:)
  end

  shared_context 'when book_in_bookcase owner logged in' do
    before do
      login_as(owner)
    end
  end

  shared_context 'when book_in_bookcase other owner logged in' do
    before do
      login_as(other_owner)
    end
  end

  describe 'GET /show' do
    it 'renders html a successful response' do
      get user_bookcase_book_in_bookcase_url(bookcase.user.name, bookcase, book_in_bookcase)
      expect(response).to be_successful
    end

    it 'renders json a successful response' do
      get user_bookcase_book_in_bookcase_url(bookcase.user.name, bookcase, book_in_bookcase).concat('.json')
      expect(response).to be_successful
    end
  end

  describe 'DELETE /destroy' do
    context 'when bookcase other owner' do
      include_context 'when book_in_bookcase other owner logged in'

      it 'raise not authorized error' do
        expect do
          delete user_bookcase_book_in_bookcase_url(bookcase.user.name, bookcase, book_in_bookcase)
        end.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'when book_in_bookcase owner' do
      include_context 'when book_in_bookcase owner logged in'

      it 'destroys the requested bookcase' do
        book_in_bookcase = create(:book_in_bookcase, bookcase: create(:bookcase, user: owner))

        expect do
          delete user_bookcase_book_in_bookcase_url(bookcase.user.name, book_in_bookcase.bookcase, book_in_bookcase)
        end.to change(BookInBookcase, :count).by(-1)
      end

      it 'redirects to the bookcases list' do
        delete user_bookcase_book_in_bookcase_url(bookcase.user.name, bookcase, book_in_bookcase)
        expect(response).to redirect_to(user_bookcase_url(bookcase.user.name, bookcase))
      end
    end
  end
end
