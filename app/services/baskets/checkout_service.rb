# frozen_string_literal: true

class Baskets::CheckoutService < BaseService
  def initialize(basket:)
    @basket = basket
    @basket_map = {}
  end

  def call
    basket_items = basket.basket_items.includes(:item)
    init_cost = 0.0
    # fill the basket map to be easily to calculate the offers and get the initial cost.
    basket_items.each do |basket_item|
      basket_map[basket_item.item.code] = { quantity: basket_item.quantity, item_price: basket_item.item.price }
      init_cost += basket_item.quantity * basket_item.item.price
    end
    discount = Items::OffersService.call(basket_map: basket_map).payload
    total_cost_after_discount = init_cost + discount
    delivery_fees = Delivery::FeesService.call(total_cost: total_cost_after_discount).payload
    invoice = {
      final_cost: (total_cost_after_discount + delivery_fees).truncate(2).to_f,
      init_cost: init_cost.to_f,
      delivery_fees: delivery_fees,
      discount: discount.truncate(2).to_f
    }
    success(invoice)
  end

  private

  attr_accessor :basket, :basket_map
end
