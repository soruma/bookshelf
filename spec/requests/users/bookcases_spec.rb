# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/:user_name/bookcases' do
  let(:owner) do
    create(:user)
  end

  let(:other_owner) do
    create(:user)
  end

  let(:valid_attributes) do
    {
      name: 'valid user',
      user_id: owner.id
    }
  end

  let(:invalid_attributes) do
    {
      name: nil,
      user_id: owner.id
    }
  end

  shared_context 'when bookcase owner logged in' do
    before do
      login_as(owner)
    end
  end

  shared_context 'when bookcase other owner logged in' do
    before do
      login_as(other_owner)
    end
  end

  describe 'GET /index' do
    include_context 'when bookcase owner logged in'

    it 'renders html a successful response' do
      Bookcase.create!(valid_attributes)
      get user_bookcases_url(owner.name)
      expect(response).to be_successful
    end

    it 'renders json a successful response' do
      Bookcase.create!(valid_attributes)
      get user_bookcases_url(owner.name).concat('.json')
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    include_context 'when bookcase owner logged in'

    it 'renders html a successful response' do
      bookcase = Bookcase.create!(valid_attributes)
      get user_bookcase_url(owner.name, bookcase)
      expect(response).to be_successful
    end

    it 'renders json a successful response' do
      bookcase = Bookcase.create!(valid_attributes)
      get user_bookcase_url(owner.name, bookcase).concat('.json')
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    context 'when bookcase other owner' do
      include_context 'when bookcase other owner logged in'

      it 'raise not authorized error' do
        bookcase = Bookcase.create!(valid_attributes)
        expect do
          get new_user_bookcase_url(owner.name, bookcase)
        end.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'when bookcase owner' do
      include_context 'when bookcase owner logged in'

      it 'renders a successful response' do
        get new_user_bookcase_url(owner.name)
        expect(response).to be_successful
      end
    end
  end

  describe 'GET /edit' do
    context 'when bookcase other owner' do
      include_context 'when bookcase other owner logged in'

      it 'raise not authorized error' do
        bookcase = Bookcase.create!(valid_attributes)
        expect do
          get edit_user_bookcase_url(owner.name, bookcase)
        end.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'when bookcase owner' do
      include_context 'when bookcase owner logged in'

      it 'renders a successful response' do
        bookcase = Bookcase.create!(valid_attributes)
        get edit_user_bookcase_url(owner.name, bookcase)
        expect(response).to be_successful
      end
    end
  end

  describe 'POST /create' do
    context 'when bookcase other owner' do
      include_context 'when bookcase other owner logged in'

      it 'raise not authorized error' do
        expect do
          post user_bookcases_url(owner.name), params: { bookcase: valid_attributes }
        end.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'when bookcase owner with valid parameters' do
      include_context 'when bookcase owner logged in'

      it 'creates a new Bookcase' do
        expect do
          post user_bookcases_url(owner.name), params: { bookcase: valid_attributes }
        end.to change(Bookcase, :count).by(1)
      end

      it 'redirects to the created bookcase' do
        post user_bookcases_url(owner.name), params: { bookcase: valid_attributes }
        expect(response).to redirect_to(user_bookcase_url(owner.name, Bookcase.last))
      end
    end

    context 'when bookcase owner with invalid parameters' do
      include_context 'when bookcase owner logged in'

      it 'does not create a new Bookcase' do
        expect do
          post user_bookcases_url(owner.name), params: { bookcase: invalid_attributes }
        end.not_to change(Bookcase, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post user_bookcases_url(owner.name), params: { bookcase: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'when bookcase other owner' do
      include_context 'when bookcase other owner logged in'

      it 'raise not authorized error' do
        bookcase = Bookcase.create!(valid_attributes)
        expect do
          patch user_bookcase_url(owner.name, bookcase)
        end.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'when bookcase owner with valid parameters' do
      include_context 'when bookcase owner logged in'

      let(:new_attributes) do
        {
          name: 'update user',
          user_id: owner.id
        }
      end

      it 'updates the requested bookcase' do
        bookcase = Bookcase.create!(valid_attributes)
        patch user_bookcase_url(owner.name, bookcase), params: { bookcase: new_attributes }
        bookcase.reload
        expect(bookcase.name).to eq 'update user'
      end

      it 'redirects to the bookcase' do
        bookcase = Bookcase.create!(valid_attributes)
        patch user_bookcase_url(owner.name, bookcase), params: { bookcase: new_attributes }
        bookcase.reload
        expect(response).to redirect_to(user_bookcase_url(owner.name, bookcase))
      end
    end

    context 'when bookcase owner with invalid parameters' do
      include_context 'when bookcase owner logged in'

      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        bookcase = Bookcase.create!(valid_attributes)
        patch user_bookcase_url(owner.name, bookcase), params: { bookcase: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    context 'when bookcase other owner' do
      include_context 'when bookcase other owner logged in'

      it 'raise not authorized error' do
        bookcase = Bookcase.create!(valid_attributes)
        expect do
          delete user_bookcase_url(owner.name, bookcase)
        end.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'when bookcase owner' do
      include_context 'when bookcase owner logged in'

      it 'destroys the requested bookcase' do
        bookcase = Bookcase.create!(valid_attributes)
        expect do
          delete user_bookcase_url(owner.name, bookcase)
        end.to change(Bookcase, :count).by(-1)
      end

      it 'redirects to the bookcases list' do
        bookcase = Bookcase.create!(valid_attributes)
        delete user_bookcase_url(owner.name, bookcase)
        expect(response).to redirect_to(user_bookcases_url(owner.name))
      end
    end
  end
end
