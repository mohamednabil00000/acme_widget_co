# frozen_string_literal: true

class BasketItem < ApplicationRecord
  include Paginatable

  # Associations
  belongs_to :basket
  belongs_to :item

  # Validations
  validates :quantity, presence: true
  validates :basket_id, presence: true, uniqueness: { scope: :item_id, message: "already exist in this basket" }
end
