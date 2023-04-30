# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :subscriber, null: false, index: { unique: true }
      t.string :email, null: false, index: true

      t.timestamps
    end
  end
end
