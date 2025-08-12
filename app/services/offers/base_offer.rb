# frozen_string_literal: true

class Offers::BaseOffer
  attr_reader :basket_map

  def initialize(basket_map:)
    @basket_map = basket_map
  end

  def is_active?
    raise NotImplementedError, "Subclasses must implement it"
  end

  def get_offer
    raise NotImplementedError, "Subclasses must implement it"
  end
end
