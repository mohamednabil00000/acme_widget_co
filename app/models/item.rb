# frozen_string_literal: true

class Item < ApplicationRecord
  include Paginatable

  # Associations
  has_many :basket_items, dependent: :destroy_async, inverse_of: :item
  has_many :baskets, through: :basket_items


  # Validations
  validates :name, presence: true, uniqueness: true, length: { maximum: 100 }
  validates :code, presence: true, uniqueness: true, length: { maximum: 10 }
  validates :price, presence: true
end
