# frozen_string_literal: true

require "rails_helper"

RSpec.describe Baskets::CreateService, type: :service do
  describe ".call" do
    context "with valid parameters" do
      it "creates a basket" do
        expect { described_class.call }.to change(Basket, :count).by(1)
      end

      it "returns a success response" do
        result = described_class.call
        expect(result).to be_success
        expect(result.payload).to be_a(Basket)
      end
    end
  end
end
