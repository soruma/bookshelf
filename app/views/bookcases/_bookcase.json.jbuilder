# frozen_string_literal: true

json.extract! bookcase, :id, :name, :user_id, :created_at, :updated_at
json.url bookcase_url(bookcase, format: :json)
