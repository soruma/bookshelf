# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bookcase do
  describe '.owned_by' do
    let(:owner) { create(:user) }
    let(:other_user) { create(:user) }

    it 'only records of the owner can be return' do
      owner_bookcase = create(:bookcase, user: owner)
      create(:bookcase, user: other_user)

      expect(described_class.owned_by(owner)).to eq [owner_bookcase]
    end
  end
end
