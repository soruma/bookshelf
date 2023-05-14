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

  describe '#already_inside?' do
    context 'when bookcase inside book' do
      let(:book) { create(:book) }
      let(:bookcase) { create(:bookcase, books: [book]) }

      it { expect(bookcase).to be_already_inside(book) }
    end

    context 'when bookcase outside book' do
      let(:book) { create(:book) }
      let(:bookcase) { create(:bookcase) }

      it { expect(bookcase).not_to be_already_inside(book) }
    end
  end
end
