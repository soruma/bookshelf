# frozen_string_literal: true

class BookcasesController < ApplicationController
  before_action :set_user
  before_action :set_bookcase, only: %i[show edit update destroy]

  def index
    @bookcases = Bookcase.on_user_at(@user)
  end

  def show; end

  def new
    @bookcase = Bookcase.new(user: @user)
  end

  def edit; end

  def create
    @bookcase = Bookcase.new(bookcase_params)

    respond_to do |format|
      if @bookcase.save
        format.html do
          redirect_to user_bookcase_url(@user.name, @bookcase), notice: I18n.t('bookcases.created_success')
        end
        format.json { render :show, status: :created, location: @bookcase }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bookcase.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @bookcase.update(bookcase_params)
        format.html do
          redirect_to user_bookcase_url(@user.name, @bookcase), notice: I18n.t('bookcases.updated_success')
        end
        format.json { render :show, status: :ok, location: @bookcase }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bookcase.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @bookcase.destroy

    respond_to do |format|
      format.html { redirect_to user_bookcases_url, notice: I18n.t('bookcases.destroyed_success') }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find_by!(name: params[:user_name])
  end

  def set_bookcase
    @bookcase = Bookcase.on_user_at(@user).find(params[:id])
  end

  def bookcase_params
    params.require(:bookcase).permit(:name, :user_id)
  end
end
