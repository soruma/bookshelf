# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :set_book, only: %i[show]

  def index
    @books = Book.eager_load(:authors)
    authorize Book
  end

  def show
    @bookcases = Bookcase.owned_by(current_user)
    authorize @book
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end
end
