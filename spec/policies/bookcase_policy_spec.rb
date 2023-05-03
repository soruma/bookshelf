# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookcasePolicy, type: :policy do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  permissions :index?, :show? do
    context 'when owner who own bookcase' do
      it 'grants access' do
        expect(described_class).to permit(user, create(:bookcase, user:))
      end
    end

    context 'when other owner who own bookcase' do
      it 'grants access' do
        expect(described_class).to permit(user, create(:bookcase, user: other_user))
      end
    end
  end

  permissions :new?, :destroy? do
    context 'when owner who own bookcase' do
      it 'grants access' do
        expect(described_class).to permit(user, create(:bookcase, user:))
      end
    end

    context 'when other owner who own bookcase' do
      it 'denies access' do
        expect(described_class).not_to permit(user, create(:bookcase, user: other_user))
      end
    end
  end

  permissions :create? do
    context 'when owner who own bookcase' do
      it 'grants access' do
        expect(described_class).to permit(user, create(:bookcase, user:))
      end
    end

    it 'denies access' do
      expect(described_class).not_to permit(user, create(:bookcase, user: other_user))
    end
  end

  permissions :edit?, :update? do
    context 'when owner who own bookcase' do
      it 'grants access' do
        expect(described_class).to permit(user, create(:bookcase, user:))
      end
    end

    context 'when other owner who own bookcase' do
      it 'denies access' do
        expect(described_class).not_to permit(user, create(:bookcase, user: other_user))
      end
    end
  end
end
