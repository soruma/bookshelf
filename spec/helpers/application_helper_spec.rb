# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe '#menu_item_class' do
    shared_context 'when menu_item is lowercase' do
      let(:menu_item) { 'dashboard' }
    end

    shared_context 'when menu_item is uppercase' do
      let(:menu_item) { 'DASHBOARD' }
    end

    shared_context 'when title is lowercase' do
      let(:title) { 'dashboard' }
    end

    shared_context 'when title is uppercase' do
      let(:title) { 'DASHBOARD' }
    end

    shared_context 'when title is other string' do
      let(:title) { 'other string' }
    end

    context 'when menu_item and title is lowercase' do
      include_context 'when menu_item is lowercase'
      include_context 'when title is lowercase'

      it 'return current class' do
        allow(helper).to receive(:menu_item_current_class)
        helper.menu_item_class(menu_item, title)

        expect(helper).to have_received(:menu_item_current_class)
      end
    end

    context 'when menu_item is lowercase and title is uppercase' do
      include_context 'when menu_item is lowercase'
      include_context 'when title is uppercase'

      it 'return current class' do
        allow(helper).to receive(:menu_item_current_class)
        helper.menu_item_class(menu_item, title)

        expect(helper).to have_received(:menu_item_current_class)
      end
    end

    context 'when menu_item and title is uppercase' do
      include_context 'when menu_item is uppercase'
      include_context 'when title is uppercase'

      it 'return current class' do
        allow(helper).to receive(:menu_item_current_class)
        helper.menu_item_class(menu_item, title)

        expect(helper).to have_received(:menu_item_current_class)
      end
    end

    context 'when menu_item is uppercase and title is lowercase' do
      include_context 'when menu_item is uppercase'
      include_context 'when title is lowercase'

      it 'return current class' do
        allow(helper).to receive(:menu_item_current_class)
        helper.menu_item_class(menu_item, title)

        expect(helper).to have_received(:menu_item_current_class)
      end
    end

    context 'when menu_item is lowercase and title is other string' do
      include_context 'when menu_item is uppercase'
      include_context 'when title is other string'

      it 'return default class' do
        allow(helper).to receive(:menu_item_default_class)
        helper.menu_item_class(menu_item, title)

        expect(helper).to have_received(:menu_item_default_class)
      end
    end
  end

  describe '#mobile_menu_item_class' do
    shared_context 'when menu_item is lowercase' do
      let(:menu_item) { 'dashboard' }
    end

    shared_context 'when menu_item is uppercase' do
      let(:menu_item) { 'DASHBOARD' }
    end

    shared_context 'when title is lowercase' do
      let(:title) { 'dashboard' }
    end

    shared_context 'when title is uppercase' do
      let(:title) { 'DASHBOARD' }
    end

    shared_context 'when title is other string' do
      let(:title) { 'other string' }
    end

    context 'when menu_item and title is lowercase' do
      include_context 'when menu_item is lowercase'
      include_context 'when title is lowercase'

      it 'return current class' do
        allow(helper).to receive(:mobile_menu_item_current_class)
        helper.mobile_menu_item_class(menu_item, title)

        expect(helper).to have_received(:mobile_menu_item_current_class)
      end
    end

    context 'when menu_item is lowercase and title is uppercase' do
      include_context 'when menu_item is lowercase'
      include_context 'when title is uppercase'

      it 'return current class' do
        allow(helper).to receive(:mobile_menu_item_current_class)
        helper.mobile_menu_item_class(menu_item, title)

        expect(helper).to have_received(:mobile_menu_item_current_class)
      end
    end

    context 'when menu_item and title is uppercase' do
      include_context 'when menu_item is uppercase'
      include_context 'when title is uppercase'

      it 'return current class' do
        allow(helper).to receive(:mobile_menu_item_current_class)
        helper.mobile_menu_item_class(menu_item, title)

        expect(helper).to have_received(:mobile_menu_item_current_class)
      end
    end

    context 'when menu_item is uppercase and title is lowercase' do
      include_context 'when menu_item is uppercase'
      include_context 'when title is lowercase'

      it 'return current class' do
        allow(helper).to receive(:mobile_menu_item_current_class)
        helper.mobile_menu_item_class(menu_item, title)

        expect(helper).to have_received(:mobile_menu_item_current_class)
      end
    end

    context 'when menu_item is lowercase and title is other string' do
      include_context 'when menu_item is uppercase'
      include_context 'when title is other string'

      it 'return default class' do
        allow(helper).to receive(:mobile_menu_item_default_class)
        helper.mobile_menu_item_class(menu_item, title)

        expect(helper).to have_received(:mobile_menu_item_default_class)
      end
    end
  end
end
