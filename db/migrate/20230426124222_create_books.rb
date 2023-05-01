# frozen_string_literal: true

class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title, null: false, index: true
      t.string :description
      t.integer :page, null: false
      t.string :isbn
      t.string :asin

      t.timestamps
    end
  end
end
