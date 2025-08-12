# frozen_string_literal: true

require "rails_helper"

RSpec.describe BasketItems::AddService, type: :service do
  describe ".call" do
    context "with valid parameters" do
      let(:basket) { create(:basket) }
      let(:item) { create(:item) }

      context "when basket item is not created before" do
        it "creates a basket item" do
          expect { described_class.call(basket: basket, item: item, basket_item_params: {}) }.to change(BasketItem, :count).by(1)
        end

        it "returns a success response" do
          result = described_class.call(basket: basket, item: item, basket_item_params: {})
          expect(result).to be_success
          expect(result.payload).to be_a(BasketItem)
        end
      end

      context "when basket item is already created before" do
        let!(:basket_item) { create(:basket_item, basket: basket, item: item) }

        it "increment the quantity" do
          expect { described_class.call(basket: basket, item: item, basket_item_params: {}) }.not_to change(BasketItem, :count)
          expect(basket_item.reload.quantity).to eq 2
        end
      end
    end
  end
end
