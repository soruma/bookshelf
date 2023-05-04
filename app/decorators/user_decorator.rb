# frozen_string_literal: true

module UserDecorator
  def avatar_url
    m5 = Digest::MD5.hexdigest(email)

    "https://icotar.com/avatar/#{m5}"
  end
end
