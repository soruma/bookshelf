# frozen_string_literal: true

class MyLoggingMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    Rails.logger.debug 'BEFORE'
    response = @app.call(env)
    Rails.logger.debug 'AFTER'
    response
  end
end

Rails.application.config.middleware.insert_after Rails::Rack::Logger, MyLoggingMiddleware
