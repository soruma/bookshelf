# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    subscriber { 'MyString' }
    email { 'MyString' }
  end
end
