# frozen_string_literal: true

class CreateBasketItems < ActiveRecord::Migration[8.0]
  def change
    create_table :basket_items do |t|
      t.references :basket, null: false, foreign_key: { on_delete: :cascade }
      t.references :item, null: false, foreign_key: { on_delete: :cascade }
      t.integer :quantity, default: 1

      t.timestamps
    end
  end
end
