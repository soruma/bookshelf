# frozen_string_literal: true

class BookcasesController < ApplicationController
  before_action :set_bookcase, only: %i[show edit update destroy]

  def index
    @bookcases = Bookcase.in_shelf_at(@current_user)
  end

  def show; end

  def new
    @bookcase = Bookcase.new(user: @current_user)
  end

  def edit; end

  def create
    @bookcase = Bookcase.new(bookcase_params)

    respond_to do |format|
      if @bookcase.save
        format.html { redirect_to bookcase_url(@bookcase), notice: 'Bookcase was successfully created.' }
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
        format.html { redirect_to bookcase_url(@bookcase), notice: 'Bookcase was successfully updated.' }
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
      format.html { redirect_to bookcases_url, notice: 'Bookcase was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_bookcase
    @bookcase = Bookcase.find(params[:id])
  end

  def bookcase_params
    params.require(:bookcase).permit(:name, :user_id)
  end
end
