# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Bookshelf
  class Application < Rails::Application
    config.generators do |generate|
      generate.javascripts false
      generate.stylesheets false
      generate.helper false
      generate.assets false
      generate.test_framework :rspec,
                              fixture: true,
                              view_specs: false,
                              routing_specs: false,
                              controller_specs: false,
                              request_specs: true
      generate.fixture_replacement :factory_bot, dir: 'spec/factories'
    end
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.action_dispatch.rescue_responses['Pundit::NotAuthorizedError'] = :forbidden

    config.autoload_paths += %W[#{config.root}/lib]
  end
end
