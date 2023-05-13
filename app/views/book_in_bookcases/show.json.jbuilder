# frozen_string_literal: true

json.extract! @book_in_bookcase, :id, :created_at, :updated_at
json.url user_bookcase_book_in_bookcase_url(@user.name, @bookcase, @book_in_bookcase, format: :json)
json.book do
  json.partial! 'books/book', book: @book_in_bookcase.book
end
json.bookcase do
  json.partial! 'bookcases/bookcase', bookcase: @bookcase
end
