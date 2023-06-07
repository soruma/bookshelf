# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthorPolicy, type: :policy do
  let(:user) { create(:user, is_admin:) }

  shared_context 'when is admin' do
    let(:is_admin) { true }
  end

  shared_context 'when is not admin' do
    let(:is_admin) { false }
  end

  permissions :index?, :show? do
    context 'when is admin' do
      include_context 'when is admin'

      it 'grants access' do
        expect(described_class).to permit(user, create(:book))
      end
    end

    context 'when is not admin' do
      include_context 'when is not admin'

      it 'grants access' do
        expect(described_class).to permit(user, create(:book))
      end
    end
  end

  permissions :new?, :create?, :destroy?, :edit?, :update? do
    context 'when is admin' do
      include_context 'when is admin'

      it 'grants access' do
        expect(described_class).to permit(user, create(:book))
      end
    end

    context 'when is not admin' do
      include_context 'when is not admin'

      it 'denies access' do
        expect(described_class).not_to permit(user, create(:book))
      end
    end
  end
end
