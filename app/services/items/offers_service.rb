# frozen_string_literal: true

class Items::OffersService < BaseService
  def initialize(basket_map:)
    @basket_map = basket_map
  end

  def call
    # return all discounts we have d1 + d2 + ...
    success(ro1_discount * -1)
  end

  private

  attr_accessor :basket_map

  def ro1_discount
    if basket_map.include?("R01")
      return ((basket_map["R01"][:quantity] / 2) * (basket_map["R01"][:item_price] / 2.0))
    end
    0
  end
end
