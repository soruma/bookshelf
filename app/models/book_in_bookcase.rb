# frozen_string_literal: true

class BookInBookcase < ApplicationRecord
  belongs_to :bookcase
  belongs_to :book
end
