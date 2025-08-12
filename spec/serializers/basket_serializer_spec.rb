# frozen_string_literal: true

require "rails_helper"

RSpec.describe BasketSerializer do
  let(:basket) { create(:basket) }

  subject { described_class.item(basket) }

  describe "#as_json" do
    it "includes the basket's attributes" do
      expect(subject.as_json).to include(
        "id" => basket.id
      )
    end
  end
end
