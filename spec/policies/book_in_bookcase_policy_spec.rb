# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookInBookcasePolicy, type: :policy do
  shared_context 'when owner is equals from current_user' do
    let(:current_user) { create(:user, is_admin:) }
    let(:owner) { current_user }
  end

  shared_context 'when owner is different from current_user' do
    let(:current_user) { create(:user, is_admin:) }
    let(:owner) { create(:user) }
  end

  shared_context 'when is admin' do
    let(:is_admin) { true }
  end

  shared_context 'when is not admin' do
    let(:is_admin) { false }
  end

  let(:book_in_bookcase) do
    bookcase = create(:bookcase, user: owner)
    create(:book_in_bookcase, bookcase:)
  end

  permissions :index?, :show? do
    context 'when owner is equals from current_user is admin' do
      include_context 'when owner is equals from current_user'
      include_context 'when is admin'

      it 'grants access' do
        expect(described_class).to permit(current_user, book_in_bookcase)
      end
    end

    context 'when owner is equals from current_user is not admin' do
      include_context 'when owner is equals from current_user'
      include_context 'when is not admin'

      it 'grants access' do
        expect(described_class).to permit(current_user, book_in_bookcase)
      end
    end

    context 'when owner is different from current_user is admin' do
      include_context 'when owner is different from current_user'
      include_context 'when is admin'

      it 'grants access' do
        expect(described_class).to permit(current_user, book_in_bookcase)
      end
    end

    context 'when owner is different from current_user is not admin' do
      include_context 'when owner is different from current_user'
      include_context 'when is not admin'

      it 'grants access' do
        expect(described_class).to permit(current_user, book_in_bookcase)
      end
    end
  end

  permissions :new? do
    context 'when owner is equals from current_user is admin' do
      include_context 'when owner is equals from current_user'
      include_context 'when is admin'

      it 'grants access' do
        expect(described_class).to permit(current_user, book_in_bookcase)
      end
    end

    context 'when owner is equals from current_user is not admin' do
      include_context 'when owner is equals from current_user'
      include_context 'when is not admin'

      it 'grants access' do
        expect(described_class).to permit(current_user, book_in_bookcase)
      end
    end

    context 'when owner is different from current_user is admin' do
      include_context 'when owner is different from current_user'
      include_context 'when is admin'

      it 'grants access' do
        expect(described_class).to permit(current_user, book_in_bookcase)
      end
    end

    context 'when owner is different from current_user is not admin' do
      include_context 'when owner is different from current_user'
      include_context 'when is not admin'

      it 'denies access' do
        expect(described_class).not_to permit(current_user, book_in_bookcase)
      end
    end
  end

  permissions :create?, :destroy?, :edit?, :update? do
    context 'when owner is equals from current_user is admin' do
      include_context 'when owner is equals from current_user'
      include_context 'when is admin'

      it 'grants access' do
        expect(described_class).to permit(current_user, book_in_bookcase)
      end
    end

    context 'when owner is equals from current_user is not admin' do
      include_context 'when owner is equals from current_user'
      include_context 'when is not admin'

      it 'grants access' do
        expect(described_class).to permit(current_user, book_in_bookcase)
      end
    end

    context 'when owner is different from current_user is admin' do
      include_context 'when owner is different from current_user'
      include_context 'when is admin'

      it 'grants access' do
        expect(described_class).to permit(current_user, book_in_bookcase)
      end
    end

    context 'when owner is different from current_user is not admin' do
      include_context 'when owner is different from current_user'
      include_context 'when is not admin'

      it 'denies access' do
        expect(described_class).not_to permit(current_user, book_in_bookcase)
      end
    end
  end
end
