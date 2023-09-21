# frozen_string_literal: true

require 'test/unit'
require_relative '../src/app'
require_relative '../src/bad_user_name_exception'

class TestApp < Test::Unit::TestCase
  def setup
    ENV['BAD_USER_NAMES'] = %w[admin rails].join(',')
  end

  def test_input_bad_user_name
    event = { 'userName' => 'admin' }
    assert_raise(BadUserNameException, 'admin is bad user name') do
      lambda_handler(event:, context: nil)
    end
  end

  def test_input_good_user_name
    event = { 'userName' => 'example' }
    assert_equal(event, lambda_handler(event:, context: nil))
  end
end
