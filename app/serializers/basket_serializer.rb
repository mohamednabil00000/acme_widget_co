# frozen_string_literal: true

class BasketSerializer < BaseSerializer
  def self.item(basket)
    {
      id: basket.id
    }
  end
end
