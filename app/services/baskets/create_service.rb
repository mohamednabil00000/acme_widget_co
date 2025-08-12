# frozen_string_literal: true

class Baskets::CreateService < BaseService
  def call
    basket = Basket.new
    return failure(basket.errors) unless basket.save

    success(basket)
  end
end
