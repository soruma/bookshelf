# frozen_string_literal: true

FactoryBot.define do
  factory :cognito_session do
    user
    expire_time { Time.zone.now.since(1.hour).tv_sec }
    issued_time { Time.zone.now.tv_sec }
    sequence(:audience) { |n| Digest::SHA256.hexdigest(n.to_s) }
    sequence(:refresh_token) { |n| Digest::SHA256.hexdigest(n.to_s) }
  end
end
