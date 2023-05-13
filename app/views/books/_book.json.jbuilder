# frozen_string_literal: true

json.extract! book, :id, :title, :description, :image_url, :page, :isbn, :asin, :created_at, :updated_at
json.authors book.authors, as: :author do |author|
  json.extract! author, :id, :name, :created_at, :updated_at
end
json.url book_url(book, format: :json)
