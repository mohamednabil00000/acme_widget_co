# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::BasketItemsController, type: :controller do
  describe "GET #index" do
    let!(:basket) { create(:basket) }
    let!(:item1) { create(:item, code: "aw1") }
    let!(:item2) { create(:item, code: "aw2") }
    let!(:basket_item1) { create(:basket_item, item: item1, basket: basket, quantity: 3) }
    let!(:basket_item2) { create(:basket_item, item: item2, basket: basket) }

    let(:json_body) { JSON.parse(response.body) }

    context "with per page eq 10" do
      it "fetch first page" do
        get :index, params: { basket_id: basket.id, per_page: 10, page: 1 }
        expect(json_body["basket_items"].size).to eq 2
        expect(json_body["basket_items"]).to match_array(
          [
            {
              "id" => basket_item1.id,
              "quantity" => 3,
              "item" => {
                "id" => item1.id,
                "name" => item1.name,
                "code" => item1.code,
                "price" => item1.price.to_f
              }
            },
            {
              "id"=> basket_item2.id,
              "quantity" => 1,
              "item" => {
                "id" => item2.id,
                "name" => item2.name,
                "code" => item2.code,
                "price" => item2.price.to_f
              }
            }
          ]
        )
      end
    end

    context "with per page eq 1" do
      it "fetch first page" do
        get :index, params: { basket_id: basket.id, per_page: 1, page: 1 }
        expect(json_body["basket_items"].size).to eq 1
        expect(json_body["basket_items"]).to match_array(
          [
            {
              "id" => basket_item1.id,
              "quantity" => 3,
              "item" => {
                "id" => item1.id,
                "name" => item1.name,
                "code" => item1.code,
                "price" => item1.price.to_f
              }
            }
          ]
        )
      end
    end
  end
end
