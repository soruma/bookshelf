# frozen_string_literal: true

class CognitoIdpController < ApplicationController
  def callback
    session[:userinfo] = request.env['omniauth.auth']

    redirect_to '/'
  end
end
