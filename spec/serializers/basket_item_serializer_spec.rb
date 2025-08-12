# frozen_string_literal: true

require "rails_helper"

RSpec.describe BasketItemSerializer do
  let!(:basket) { create(:basket) }
  let!(:item) { create(:item) }
  let!(:basket_item) { create(:basket_item, basket: basket, item: item, quantity: 10) }

  subject { described_class.item(basket_item) }

  describe "#as_json" do
    it "includes the basket_item's attributes" do
      expect(subject.as_json).to include(
        "id" => basket_item.id,
        "quantity" => 10,
        "item" => {
          "id" => item.id,
          "name" => item.name,
          "code" => item.code,
          "price" => item.price
        }
      )
    end
  end
end
