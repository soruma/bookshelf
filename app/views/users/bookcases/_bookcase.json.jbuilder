# frozen_string_literal: true

json.extract! bookcase, :id, :name, :user_id, :created_at, :updated_at
json.url user_bookcase_url(bookcase.user.name, bookcase, format: :json)
