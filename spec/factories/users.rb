# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    subscriber { 'MyString' }
    email { 'test_user@example.com' }
    name { 'test_user' }
  end
end
