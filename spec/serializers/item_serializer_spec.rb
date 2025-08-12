# frozen_string_literal: true

require "rails_helper"

RSpec.describe ItemSerializer do
  let(:item) { create(:item) }

  subject { described_class.item(item) }

  describe "#as_json" do
    it "includes the user's attributes" do
      expect(subject.as_json).to include(
        "id" => item.id,
        "name" => item.name,
        "code" => item.code,
        "price" => item.price
      )
    end
  end
end
