# frozen_string_literal: true

class Items::OffersService < BaseService
  def initialize(basket_map:)
    @basket_map = basket_map
  end

  def call
    offers = 0
    offers += red_widget_offer.get_offer if red_widget_offer.is_active?

    success(offers * -1)
  end

  private

  attr_accessor :basket_map

  def red_widget_offer
    @red_widget_offer ||= Offers::RedWidgetOffer.new(basket_map: basket_map)
  end
end
