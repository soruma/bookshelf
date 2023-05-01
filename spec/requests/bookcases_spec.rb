# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/:user_name/bookcases' do
  let(:target_user) do
    create(:user)
  end

  let(:valid_attributes) do
    {
      name: 'valid user',
      user_id: target_user.id
    }
  end

  let(:invalid_attributes) do
    {
      name: nil,
      user_id: target_user.id
    }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Bookcase.create!(valid_attributes)
      get user_bookcases_url(target_user.name)
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      bookcase = Bookcase.create!(valid_attributes)
      get user_bookcase_url(target_user.name, bookcase)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_user_bookcase_url(target_user.name)
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      bookcase = Bookcase.create!(valid_attributes)
      get edit_user_bookcase_url(target_user.name, bookcase)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Bookcase' do
        expect do
          post user_bookcases_url(target_user.name), params: { bookcase: valid_attributes }
        end.to change(Bookcase, :count).by(1)
      end

      it 'redirects to the created bookcase' do
        post user_bookcases_url(target_user.name), params: { bookcase: valid_attributes }
        expect(response).to redirect_to(user_bookcase_url(target_user.name, Bookcase.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Bookcase' do
        expect do
          post user_bookcases_url(target_user.name), params: { bookcase: invalid_attributes }
        end.not_to change(Bookcase, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post user_bookcases_url(target_user.name), params: { bookcase: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          name: 'update user',
          user_id: target_user.id
        }
      end

      it 'updates the requested bookcase' do
        bookcase = Bookcase.create!(valid_attributes)
        patch user_bookcase_url(target_user.name, bookcase), params: { bookcase: new_attributes }
        bookcase.reload
        expect(bookcase.name).to eq 'update user'
      end

      it 'redirects to the bookcase' do
        bookcase = Bookcase.create!(valid_attributes)
        patch user_bookcase_url(target_user.name, bookcase), params: { bookcase: new_attributes }
        bookcase.reload
        expect(response).to redirect_to(user_bookcase_url(target_user.name, bookcase))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        bookcase = Bookcase.create!(valid_attributes)
        patch user_bookcase_url(target_user.name, bookcase), params: { bookcase: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested bookcase' do
      bookcase = Bookcase.create!(valid_attributes)
      expect do
        delete user_bookcase_url(target_user.name, bookcase)
      end.to change(Bookcase, :count).by(-1)
    end

    it 'redirects to the bookcases list' do
      bookcase = Bookcase.create!(valid_attributes)
      delete user_bookcase_url(target_user.name, bookcase)
      expect(response).to redirect_to(user_bookcases_url(target_user.name))
    end
  end
end
