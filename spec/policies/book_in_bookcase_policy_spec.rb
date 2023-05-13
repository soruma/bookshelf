# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookInBookcasePolicy, type: :policy do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  shared_context 'when owner book_in_bookcase' do
    let(:book_in_bookcase) do
      bookcase = create(:bookcase, user:)
      create(:book_in_bookcase, bookcase:)
    end
  end

  shared_context 'when other owner book_in_bookcase' do
    let(:book_in_bookcase) do
      bookcase = create(:bookcase, user: other_user)
      create(:book_in_bookcase, bookcase:)
    end
  end

  permissions :index?, :show? do
    context 'when owner who own book_in_bookcase' do
      include_context 'when owner book_in_bookcase'

      it 'grants access' do
        expect(described_class).to permit(user, book_in_bookcase)
      end
    end

    context 'when other owner who own book_in_bookcase' do
      include_context 'when other owner book_in_bookcase'

      it 'grants access' do
        expect(described_class).to permit(user, book_in_bookcase)
      end
    end
  end

  permissions :new?, :destroy? do
    context 'when owner who own book_in_bookcase' do
      include_context 'when owner book_in_bookcase'

      it 'grants access' do
        expect(described_class).to permit(user, book_in_bookcase)
      end
    end

    context 'when other owner who own book_in_bookcase' do
      include_context 'when other owner book_in_bookcase'

      it 'denies access' do
        expect(described_class).not_to permit(user, book_in_bookcase)
      end
    end
  end

  permissions :create? do
    context 'when owner who own book_in_bookcase' do
      include_context 'when owner book_in_bookcase'

      it 'grants access' do
        expect(described_class).to permit(user, book_in_bookcase)
      end
    end

    context 'when other owner who own book_in_bookcase' do
      include_context 'when other owner book_in_bookcase'

      it 'denies access' do
        expect(described_class).not_to permit(user, book_in_bookcase)
      end
    end
  end

  permissions :edit?, :update? do
    context 'when owner who own book_in_bookcase' do
      include_context 'when owner book_in_bookcase'

      it 'grants access' do
        expect(described_class).to permit(user, book_in_bookcase)
      end
    end

    context 'when other owner who own book_in_bookcase' do
      include_context 'when other owner book_in_bookcase'

      it 'denies access' do
        expect(described_class).not_to permit(user, book_in_bookcase)
      end
    end
  end
end
