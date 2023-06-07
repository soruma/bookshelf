# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookcasePolicy, type: :policy do
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

  permissions :index?, :show? do
    context 'when owner is equals from current_user and is admin' do
      include_context 'when owner is equals from current_user'
      include_context 'when is admin'

      it 'grants access' do
        expect(described_class).to permit(current_user, create(:bookcase, user: owner))
      end
    end

    context 'when owner is equals from current_user and is not admin' do
      include_context 'when owner is equals from current_user'
      include_context 'when is not admin'

      it 'grants access' do
        expect(described_class).to permit(current_user, create(:bookcase, user: owner))
      end
    end

    context 'when owner is different from current_user and is admin' do
      include_context 'when owner is different from current_user'
      include_context 'when is admin'

      it 'grants access' do
        expect(described_class).to permit(current_user, create(:bookcase, user: owner))
      end
    end

    context 'when owner is different from current_user and is not admin' do
      include_context 'when owner is different from current_user'
      include_context 'when is not admin'

      it 'grants access' do
        expect(described_class).to permit(current_user, create(:bookcase, user: owner))
      end
    end
  end

  permissions :new? do
    context 'when owner is equals from current_user and is admin' do
      include_context 'when owner is equals from current_user'
      include_context 'when is admin'

      it 'grants access' do
        expect(described_class).to permit(current_user, create(:bookcase, user: owner))
      end
    end

    context 'when owner is equals from current_user and is not admin' do
      include_context 'when owner is equals from current_user'
      include_context 'when is not admin'

      it 'grants access' do
        expect(described_class).to permit(current_user, create(:bookcase, user: owner))
      end
    end

    context 'when owner is different from current_user and is admin' do
      include_context 'when owner is different from current_user'
      include_context 'when is admin'

      it 'grants access' do
        expect(described_class).to permit(current_user, create(:bookcase, user: owner))
      end
    end

    context 'when owner is different from current_user and is not admin' do
      include_context 'when owner is different from current_user'
      include_context 'when is not admin'

      it 'denies access' do
        expect(described_class).not_to permit(current_user, create(:bookcase, user: owner))
      end
    end
  end

  permissions :create?, :destroy?, :edit?, :update? do
    context 'when owner is equals from current_user and is admin' do
      include_context 'when owner is equals from current_user'
      include_context 'when is admin'

      it 'grants access' do
        expect(described_class).to permit(current_user, create(:bookcase, user: owner))
      end
    end

    context 'when owner is equals from current_user and is not admin' do
      include_context 'when owner is equals from current_user'
      include_context 'when is not admin'

      it 'grants access' do
        expect(described_class).to permit(current_user, create(:bookcase, user: owner))
      end
    end

    context 'when owner is different from current_user and is admin' do
      include_context 'when owner is different from current_user'
      include_context 'when is admin'

      it 'grants access' do
        expect(described_class).to permit(current_user, create(:bookcase, user: owner))
      end
    end

    context 'when owner is different from current_user and is not admin' do
      include_context 'when owner is different from current_user'
      include_context 'when is not admin'

      it 'denies access' do
        expect(described_class).not_to permit(current_user, create(:bookcase, user: owner))
      end
    end
  end
end
