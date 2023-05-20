# frozen_string_literal: true

# From: https://github.com/mheffner/rails-cognito-example
class ApplicationController < ActionController::Base
  include Pundit::Authorization

  attr_reader :current_user

  private

  def authenticate_user!
    redirect_to(root_path) unless signed_in?
  end

  def signed_in?
    session[:userinfo].present?
  end

  helper_method :signed_in?
end
