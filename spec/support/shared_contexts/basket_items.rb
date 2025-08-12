# frozen_string_literal: true

RSpec.shared_context "generate real items" do
  let!(:item1) { create(:item, name: "Red Widget", code: "R01", price: "32.95") }
  let!(:item2) { create(:item, name: "Green Widget", code: "G01", price: "24.95") }
  let!(:item3) { create(:item, name: "Blue Widget", code: "B01", price: "7.95") }
end
