# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:subscriber) { |n| Digest::SHA256.hexdigest(n.to_s) }
    sequence(:email) { |n| "test_user_#{n}@example.com" }
    sequence(:name) { |n| "test_user_#{n}" }
  end
end
