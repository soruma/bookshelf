# frozen_string_literal: true

module Books
  module Bookcases
    class BookInBookcaseController < ApplicationController
      before_action :set_book_in_bookcase, only: %(destroy)

      def create
        @book_in_bookcase = BookInBookcase.new(book_in_bookcase_params)
        authorize @book_in_bookcase

        respond_to do |format|
          if @book_in_bookcase.save
            format.html do
              redirect_to book_url(@book_in_bookcase.book),
                          notice: I18n.t('books.bookcases.book_in_bookcases.added_book_to_the_bookcase',
                                         bookcase_name: @book_in_bookcase.bookcase.name)
            end
          end
        end
      end

      def destroy
        authorize @book_in_bookcase

        respond_to do |format|
          if @book_in_bookcase.destroy
            format.html do
              redirect_to book_url(@book_in_bookcase.book),
                          notice: I18n.t('books.bookcases.book_in_bookcases.take_out_a_book_from_the_bookcase',
                                         bookcase_name: @book_in_bookcase.bookcase.name)
            end
            format.json { head :no_content }
          end
        end
      end

      private

      def set_book_in_bookcase
        @book_in_bookcase = BookInBookcase.find_by!(bookcase_id: params[:bookcase_id], book_id: params[:book_id])
      end

      def book_in_bookcase_params
        params.permit(:bookcase_id, :book_id)
      end
    end
  end
end
