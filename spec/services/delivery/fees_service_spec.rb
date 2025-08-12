# frozen_string_literal: true

require "rails_helper"

RSpec.describe Delivery::FeesService, type: :service do
  describe ".call" do
    context "with total cost >= 90" do
      it "returns a zero" do
        result = described_class.call(total_cost: rand(90..10000000))
        expect(result).to be_success
        expect(result.payload).to eq 0
      end
    end

    context "with total cost < 50" do
      it "returns a zero" do
        result = described_class.call(total_cost: rand(0..49))
        expect(result).to be_success
        expect(result.payload).to eq 4.95
      end
    end

    context "with total cost >= 50 & < 90" do
      it "returns a zero" do
        result = described_class.call(total_cost: rand(50..89))
        expect(result).to be_success
        expect(result.payload).to eq 2.95
      end
    end
  end
end
