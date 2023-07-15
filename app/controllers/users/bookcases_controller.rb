# frozen_string_literal: true

module Users
  class BookcasesController < ApplicationController
    before_action :set_user
    before_action :set_bookcase, only: %i[edit update destroy bookcase]

    def index
      @bookcases = Bookcase.owned_by(@user)
      @new_bookcase = Bookcase.new(user: @user)
      authorize Bookcase
    end

    def show
      @bookcase = Bookcase.owned_by(@user).eager_load(book_in_bookcase: { book: :authors }).find(params[:id])

      authorize @bookcase
    end

    def new
      @bookcase = Bookcase.new(user: @user)
      authorize @bookcase
    end

    def edit
      authorize @bookcase
    end

    def create
      @bookcase = Bookcase.new(bookcase_params)
      authorize @bookcase

      return if @bookcase.save

      render :new, status: :unprocessable_entity
    end

    def update
      authorize @bookcase
      respond_to do |format|
        if @bookcase.update(bookcase_params)
          format.turbo_stream
          format.json { render :show, status: :ok, location: @bookcase }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @bookcase.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      authorize @bookcase
      @bookcase.destroy

      respond_to do |format|
        format.html { redirect_to user_bookcases_url, notice: I18n.t('users.bookcases.destroyed_success') }
        format.json { head :no_content }
      end
    end

    def bookcase
      @bookcase = Bookcase.owned_by(@user).find(params[:id])
    end

    private

    def set_user
      @user = User.find_by!(name: params[:user_name])
    end

    def set_bookcase
      @bookcase = Bookcase.owned_by(@user).find(params[:id])
    end

    def bookcase_params
      params.require(:bookcase).permit(:name, :user_id)
    end
  end
end
