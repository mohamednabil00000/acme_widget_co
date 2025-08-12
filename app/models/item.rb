# frozen_string_literal: true

class Item < ApplicationRecord
  # Validations
  validates :name, presence: true, uniqueness: true, length: { maximum: 100 }
  validates :code, presence: true, uniqueness: true, length: { maximum: 10 }
  validates :price, presence: true
end
