# frozen_string_literal: true

FactoryBot.define do
  factory :basket_item do
    basket
    item
    quantity { 1 }
  end
end
