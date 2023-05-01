# frozen_string_literal: true

class CreateBookInBookcases < ActiveRecord::Migration[7.0]
  def change
    create_table :book_in_bookcases do |t|
      t.references :bookcase, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
