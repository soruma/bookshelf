# frozen_string_literal: true

class CreateCognitoSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :cognito_sessions do |t|
      t.references :user, index: true, null: false, foreign_key: true
      t.integer :expire_time, null: false
      t.integer :issued_time, null: false
      t.string :audience, null: false
      t.text :refresh_token, null: false

      t.timestamps
    end
  end
end
