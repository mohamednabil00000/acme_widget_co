# frozen_string_literal: true

class Offers::RedWidgetOffer < Offers::BaseOffer
  def is_active?
    true # later one it should be feature flags to control it from admin panel
  end

  def get_offer
    if basket_map.include?("R01")
      return ((basket_map["R01"][:quantity] / 2) * (basket_map["R01"][:item_price] / 2.0))
    end
    0
  end
end
