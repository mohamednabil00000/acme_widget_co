# frozen_string_literal: true

class Basket < ApplicationRecord
  include Paginatable

  # Associations
  has_many :basket_items, dependent: :destroy_async, inverse_of: :basket
  has_many :items, through: :basket_items
end
