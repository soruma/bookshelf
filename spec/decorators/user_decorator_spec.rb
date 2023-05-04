# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserDecorator do
  subject { user }

  let(:user) { User.new.extend described_class }

  it { is_expected.to be_a User }

  describe '#avatar_url' do
    let(:user) { create(:user, email: 'test_data@example.com').extend described_class }

    it 'return a join of icotar.com/avatar and m5 hexdigest' do
      m5 = Digest::MD5.hexdigest(user.email)

      expect(user.avatar_url).to eq "https://icotar.com/avatar/#{m5}"
    end
  end
end
