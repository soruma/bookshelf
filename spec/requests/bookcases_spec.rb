# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/bookcases' do
  let(:valid_attributes) do
    skip('Add a hash of attributes valid for your model')
  end

  let(:invalid_attributes) do
    skip('Add a hash of attributes invalid for your model')
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Bookcase.create! valid_attributes
      get bookcases_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      bookcase = Bookcase.create! valid_attributes
      get bookcase_url(bookcase)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_bookcase_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      bookcase = Bookcase.create! valid_attributes
      get edit_bookcase_url(bookcase)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Bookcase' do
        expect do
          post bookcases_url, params: { bookcase: valid_attributes }
        end.to change(Bookcase, :count).by(1)
      end

      it 'redirects to the created bookcase' do
        post bookcases_url, params: { bookcase: valid_attributes }
        expect(response).to redirect_to(bookcase_url(Bookcase.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Bookcase' do
        expect do
          post bookcases_url, params: { bookcase: invalid_attributes }
        end.not_to change(Bookcase, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post bookcases_url, params: { bookcase: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested bookcase' do
        bookcase = Bookcase.create! valid_attributes
        patch bookcase_url(bookcase), params: { bookcase: new_attributes }
        bookcase.reload
        skip('Add assertions for updated state')
      end

      it 'redirects to the bookcase' do
        bookcase = Bookcase.create! valid_attributes
        patch bookcase_url(bookcase), params: { bookcase: new_attributes }
        bookcase.reload
        expect(response).to redirect_to(bookcase_url(bookcase))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        bookcase = Bookcase.create! valid_attributes
        patch bookcase_url(bookcase), params: { bookcase: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested bookcase' do
      bookcase = Bookcase.create! valid_attributes
      expect do
        delete bookcase_url(bookcase)
      end.to change(Bookcase, :count).by(-1)
    end

    it 'redirects to the bookcases list' do
      bookcase = Bookcase.create! valid_attributes
      delete bookcase_url(bookcase)
      expect(response).to redirect_to(bookcases_url)
    end
  end
end
