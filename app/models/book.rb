# frozen_string_literal: true

class Book < ApplicationRecord
  has_many :book_authors, dependent: :destroy
  has_many :authors, through: :book_authors

  validates :title, :description, :page, :image_url, presence: true
  validate :required_either_isbn_or_asin

  private

  def required_either_isbn_or_asin
    return if isbn.present? ^ asin.present?

    errors.add(:base, I18n.t('.book.required_either_isbn_or_asin'))
  end
end
