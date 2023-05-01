# frozen_string_literal: true

class CreateAuthors < ActiveRecord::Migration[7.0]
  def change
    create_table :authors do |t|
      t.string :name, null: false, index: true

      t.timestamps
    end
  end
end
