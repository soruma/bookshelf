# frozen_string_literal: true

class Book < ApplicationRecord
  validates :title, :description, :page, presence: true
  validate :required_either_isbn_or_asin

  private

  def required_either_isbn_or_asin
    return if isbn.present? ^ asin.present?

    errors.add(:base, I18n.t('models.book.required_either_isbn_or_asin'))
  end
end
