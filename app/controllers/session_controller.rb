# frozen_string_literal: true

# From: https://github.com/mheffner/rails-cognito-example
class SessionController < ApplicationController
  def signin
    redirect_to cognito_signin_url, allow_other_host: true
  end

  def signout
    redirect_to cognito_signout_url, allow_other_host: true
  end

  def signup
    redirect_to cognito_signup_url, allow_other_host: true
  end

  private

  def cognito_signin_url
    Cognito::Urls.login_uri(ENV.fetch('AWS_COGNITO_APP_CLIENT_ID', nil),
                            signin_redirect_uri)
  end

  def cognito_signup_url
    Cognito::Urls.signup_uri(ENV.fetch('AWS_COGNITO_APP_CLIENT_ID', nil),
                             signin_redirect_uri)
  end

  def cognito_signout_url
    Cognito::Urls.logout_uri(ENV.fetch('AWS_COGNITO_APP_CLIENT_ID', nil),
                             signout_redirect_uri)
  end

  def signin_redirect_uri
    auth_signin_url
  end

  def signout_redirect_uri
    auth_signout_url
  end
end
