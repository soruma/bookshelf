# frozen_string_literal: true

module Users
  module Bookcases
    class BookInBookcasesController < ApplicationController
      before_action :set_user, only: %i[show destroy]
      before_action :set_bookcase, only: %i[show destroy]
      before_action :set_book_in_bookcase, only: %i[show destroy]

      def show
        authorize @book_in_bookcase
      end

      def destroy
        authorize @book_in_bookcase
        @book_in_bookcase.destroy

        respond_to do |format|
          format.html do
            redirect_to user_bookcase_url(@user.name, @bookcase),
                        notice: I18n.t('users.bookcases.book_in_bookcases.off_the_bookcase',
                                       title: @book_in_bookcase.book.title)
          end
          format.json { head :no_content }
        end
      end

      private

      def set_user
        @user = User.find_by!(name: params[:user_name])
      end

      def set_bookcase
        @bookcase = Bookcase.owned_by(@user).find(params[:bookcase_id])
      end

      def set_book_in_bookcase
        @book_in_bookcase = BookInBookcase.find_by!(id: params[:id], bookcase: @bookcase)
      end
    end
  end
end
