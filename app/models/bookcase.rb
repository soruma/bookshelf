# frozen_string_literal: true

class Bookcase < ApplicationRecord
  belongs_to :user
  has_many :book_in_bookcase, dependent: :destroy
  has_many :books, through: :book_in_bookcase

  validates :name, presence: true

  scope :owned_by, ->(user) { where(user:) }
end
