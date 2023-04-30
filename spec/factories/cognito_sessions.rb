# frozen_string_literal: true

FactoryBot.define do
  factory :cognito_session do
    user { nil }
    expire_time { 1 }
    issued_time { 1 }
    audience { 'MyString' }
    refresh_token { 'MyText' }
  end
end
