# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookPolicy, type: :policy do
  let(:user) { create(:user) }

  permissions :index?, :show? do
    it 'grants access' do
      expect(described_class).to permit(user, create(:book))
    end
  end

  permissions :new?, :create?, :destroy?, :edit?, :update? do
    it 'denies access' do
      expect(described_class).not_to permit(user, create(:book))
    end
  end
end
