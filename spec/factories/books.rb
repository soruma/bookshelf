# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { 'MyString' }
    description { 'MyString' }
    page { 1 }
    isbn { 'MyString' }
    asin { 'MyString' }
  end
end
