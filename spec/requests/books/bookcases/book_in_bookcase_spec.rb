# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'books/:book_id/bookcases/:bookcase_id/book_in_bookcase' do
  let(:owner) do
    create(:user)
  end

  let(:bookcase) do
    create(:bookcase, user: owner)
  end

  shared_context 'when book_in_bookcase owner logged in' do
    before do
      login_as(owner)
    end
  end

  describe 'POST /create' do
    context 'without login' do
      it 'raise not authorized error' do
        book_in_bookcase = create(:book_in_bookcase, bookcase:)

        expect do
          post book_bookcase_book_in_bookcase_url(book_in_bookcase.book, bookcase)
        end.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'when login for book_in_bookcase owner' do
      include_context 'when book_in_bookcase owner logged in'

      it 'creates a new BookInBookcase' do
        book_in_bookcase = create(:book_in_bookcase, bookcase:)

        expect do
          post book_bookcase_book_in_bookcase_url(book_in_bookcase.book, bookcase)
        end.to change(BookInBookcase, :count).by(1)
      end

      it 'redirects to the created book_in_bookcase' do
        book_in_bookcase = create(:book_in_bookcase, bookcase:)

        post book_bookcase_book_in_bookcase_url(book_in_bookcase.book, bookcase)
        expect(response).to redirect_to(book_url(book_in_bookcase.book))
      end
    end
  end

  describe 'DELETE /destroy' do
    context 'without login' do
      it 'raise not authorized error' do
        book_in_bookcase = create(:book_in_bookcase, bookcase:)

        expect do
          delete book_bookcase_book_in_bookcase_url(book_in_bookcase.book, bookcase)
        end.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'when login for book_in_bookcase owner' do
      include_context 'when book_in_bookcase owner logged in'

      it 'destroys the requested book_in_bookcase' do
        book_in_bookcase = create(:book_in_bookcase, bookcase:)

        expect do
          delete book_bookcase_book_in_bookcase_url(book_in_bookcase.book, bookcase)
        end.to change(BookInBookcase, :count).by(-1)
      end

      it 'redirects to the book' do
        book_in_bookcase = create(:book_in_bookcase, bookcase:)

        delete book_bookcase_book_in_bookcase_url(book_in_bookcase.book, bookcase)
        expect(response).to redirect_to(book_url(book_in_bookcase.book))
      end
    end
  end
end
