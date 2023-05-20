# frozen_string_literal: true

# From: https://github.com/mheffner/rails-cognito-example
class SessionController < ApplicationController
  def destroy
    reset_session
    redirect_to cognito_logout_url
  end
end
