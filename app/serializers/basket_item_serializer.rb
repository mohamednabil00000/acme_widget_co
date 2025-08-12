# frozen_string_literal: true

class BasketItemSerializer < BaseSerializer
  def self.item(basket_item)
    {
      id: basket_item.id,
      quantity: basket_item.quantity,
      item: ItemSerializer.item(basket_item.item)
    }
  end
end
