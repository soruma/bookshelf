# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { 'MyString' }
    description { 'MyString' }
    page { 1 }
    image_url { 'https://m.media-amazon.com/images/I/01MKUOLsA5L._BO1,204,203,200_.gif' }
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
