# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  add_group 'Controllers', 'app/controllers'
  add_group 'Decorators', 'app/decorators'
  add_group 'Helpers', 'app/helpers'
  add_group 'Models', 'app/models'
  add_group 'Policies', 'app/policies'

  add_filter '/config/'
  add_filter '/spec/'
  add_filter '/vendor/'

  enable_coverage :branch
end
