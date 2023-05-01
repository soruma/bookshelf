# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show]

  def show; end

  def set_user
    @user = User.find_by!(name: params[:name])
  end
end
