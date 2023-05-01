# frozen_string_literal: true

class User < ApplicationRecord
  has_many :bookcase, dependent: :destroy
  has_many :cognito_sessions, dependent: :destroy

  validates :name, :subscriber, uniqueness: true
end
