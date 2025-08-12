# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::BasketItemsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/api/v1/baskets/:basket_id/basket_items").to route_to("api/v1/basket_items#index", basket_id: ':basket_id')
    end
  end
end
