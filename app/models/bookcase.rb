# frozen_string_literal: true

class Bookcase < ApplicationRecord
  belongs_to :user
  has_many :book_in_bookcase, dependent: :destroy
  has_many :books, through: :book_in_bookcase
end