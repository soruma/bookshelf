# frozen_string_literal: true

class RailsAdminParentController < ApplicationController
  around_action :skip_bullet

  def skip_bullet
    previous_value = nil

    yield
  ensure
    Bullet.enable = previous_value
  end
end
