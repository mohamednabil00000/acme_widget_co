# frozen_string_literal: true

class CreateBaskets < ActiveRecord::Migration[8.0]
  def change
    create_table :baskets do |t|
      t.timestamps
    end
  end
end
