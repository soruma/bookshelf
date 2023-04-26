# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do
  describe '#required_either_isbn_or_asin' do
    shared_context 'when isbn is nil' do
      let(:isbn) { nil }
    end

    shared_context 'when isbn is not nil' do
      let(:isbn) { 'isbn' }
    end

    shared_context 'when asin is nil' do
      let(:asin) { nil }
    end

    shared_context 'when asin is not nil' do
      let(:asin) { 'asin' }
    end

    let(:book) { build(:book, isbn:, asin:) }

    context 'when isbn and asin is nil' do
      include_context 'when isbn is nil'
      include_context 'when asin is nil'

      it 'is invalid' do
        expect(book).to be_invalid
      end
    end

    context 'when isbn is nil and asin is nil' do
      include_context 'when isbn is not nil'
      include_context 'when asin is nil'

      it 'is valid' do
        expect(book).to be_valid
      end
    end

    context 'when isbn is nil and asin is not nil' do
      include_context 'when isbn is nil'
      include_context 'when asin is not nil'

      it 'is valid' do
        expect(book).to be_valid
      end
    end

    context 'when isbn and asin is not nil' do
      include_context 'when isbn is not nil'
      include_context 'when asin is not nil'

      it 'is invalid' do
        expect(book).to be_invalid
      end
    end
  end
end
