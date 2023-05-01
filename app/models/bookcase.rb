# frozen_string_literal: true

class Bookcase < ApplicationRecord
  belongs_to :user
  has_many :book_in_bookcase, dependent: :destroy
  has_many :books, through: :book_in_bookcase

  validates :name, presence: true

  scope :in_shelf_at, ->(user) { where(user:) }
end
