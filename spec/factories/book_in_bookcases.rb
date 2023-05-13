# frozen_string_literal: true

FactoryBot.define do
  factory :book_in_bookcase do
    bookcase
    book
  end
end
