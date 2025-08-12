# frozen_string_literal: true

require "rails_helper"

RSpec.describe Items::OffersService, type: :service do
  describe ".call" do
    describe "offer R01" do
      context "when there is no R01 items" do
        let(:basket_map) do
          { "G01" => { quantity: 1, item_price: 2 } }
        end

        it "returns zero" do
          expect(described_class.call(basket_map: basket_map).payload).to eq 0
        end
      end

      context "when we have only R01 item" do
        let(:basket_map) do
          { "R01" => { quantity: 1, item_price: 2 } }
        end

        it "returns zero" do
          expect(described_class.call(basket_map: basket_map).payload).to eq 0
        end
      end

      context "when we have odd number of R01" do
        let(:basket_map) do
          { "R01" => { quantity: 5, item_price: 2 } }
        end

        it "returns -2" do
          expect(described_class.call(basket_map: basket_map).payload).to eq -2
        end
      end
    end
  end
end
