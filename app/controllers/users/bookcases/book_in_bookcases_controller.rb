# frozen_string_literal: true

module Users
  module Bookcases
    class BookInBookcasesController < ApplicationController
      before_action :set_user, only: %i[show]
      before_action :set_bookcase, only: %i[show]
      before_action :set_book_in_bookcase, only: %i[show destroy]

      def show
        authorize @book_in_bookcase
      end

      private

      def set_user
        @user = User.find_by!(name: params[:user_name])
      end

      def set_bookcase
        @bookcase = Bookcase.on_user_at(@user).find(params[:bookcase_id])
      end

      def set_book_in_bookcase
        @book_in_bookcase = BookInBookcase.find_by!(id: params[:id], bookcase: @bookcase)
      end
    end
  end
end
