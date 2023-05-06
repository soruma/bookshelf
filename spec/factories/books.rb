# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { 'MyString' }
    description { 'MyString' }
    page { 1 }
    isbn { Digest::MD5.hexdigest(title) }

    factory :book_include_isbn do
      isbn { Digest::MD5.hexdigest(title) }
      asin { nil }
    end

    factory :book_include_asin do
      asin { Digest::MD5.hexdigest(title) }
      isbn { nil }
    end
  end
end
