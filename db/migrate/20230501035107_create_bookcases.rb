# frozen_string_literal: true

class CreateBookcases < ActiveRecord::Migration[7.0]
  def change
    create_table :bookcases do |t|
      t.string :name, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
