# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[8.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.decimal :price, null: false

      t.timestamps
    end
    add_index :items, :code, unique: true
  end
end
