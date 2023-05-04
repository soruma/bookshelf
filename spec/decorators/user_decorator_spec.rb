# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserDecorator do
  let(:user) { User.new.extend UserDecorator }
  subject { user }
  it { should be_a User }

  describe '#avatar_url' do
    let(:user) { create(:user, email: 'test_data@example.com').extend UserDecorator }

    it 'return a join of icotar.com/avatar and m5 hexdigest' do
      m5 = Digest::MD5.hexdigest(user.email)

      expect(user.avatar_url).to eq "https://icotar.com/avatar/#{m5}"
    end
  end
end
