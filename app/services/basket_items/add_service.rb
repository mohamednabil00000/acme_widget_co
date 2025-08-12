# frozen_string_literal: true

class BasketItems::AddService < BaseService
  def initialize(item:, basket:, basket_item_params:)
    @item = item
    @basket = basket
    @basket_item_params = basket_item_params
  end

  def call
    basket_item = BasketItem.find_by(item_id: item.id, basket_id: basket.id)

    if basket_item
      basket_item.increment(:quantity, quantity)
    else
      basket_item = BasketItem.new(
        item_id: item.id,
        basket_id: basket.id,
        quantity: quantity)
    end

    return failure(basket_item.errors) unless basket_item.save

    success(basket_item)
  end

  private

  attr_reader :item, :basket, :basket_item_params

  def quantity
    basket_item_params[:quantity].nil? ? 1 : basket_item_params[:quantity]
  end
end
