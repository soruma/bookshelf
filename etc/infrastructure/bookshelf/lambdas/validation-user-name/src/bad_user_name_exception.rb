# frozen_string_literal: true

class BadUserNameException < StandardError
  def initialize(user_name)
    msg = "#{user_name} is bad user name"
    super(msg)
  end
end
