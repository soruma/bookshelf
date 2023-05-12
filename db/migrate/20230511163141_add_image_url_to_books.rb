# frozen_string_literal: true

class AddImageUrlToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :image_url, :string
  end
end
