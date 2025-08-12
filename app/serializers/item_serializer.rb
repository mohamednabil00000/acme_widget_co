# frozen_string_literal: true

class ItemSerializer < BaseSerializer
  def self.item(item)
    {
      id: item.id,
      name: item.name,
      code: item.code,
      price: item.price.to_f
    }
  end
end
