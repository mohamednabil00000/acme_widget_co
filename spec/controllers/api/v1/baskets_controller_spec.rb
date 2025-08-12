# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::BasketsController, type: :controller do
  let(:json_body) { JSON.parse(response.body) }

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a basket" do
        expect {
          post :create
        }.to change(Basket, :count).by(1)
      end

      it "returns a success response" do
        post :create
        expect(response).to have_http_status(:created)
        expect(json_body).to eq(
          "basket" => {
            "id" => Basket.last.id
          }
        )
      end
    end
  end

  describe "GET #checkout" do
    include_context "generate real items"
    let!(:basket) { create(:basket) }

    context "example 1" do
      let!(:basket_item1) { create(:basket_item, item: item2, basket: basket) }
      let!(:basket_item2) { create(:basket_item, item: item3, basket: basket) }

      it "returns $37.85" do
        get :checkout, params: { id: basket.id }
        expect(response).to have_http_status(:ok)
        expect(json_body).to eq(
          "invoice" => {
            "final_cost" => 37.85,
            "discount" => 0,
            "delivery_fees" => 4.95,
            "init_cost" => 32.9
          }
        )
      end
    end

    context "example 2" do
      let!(:basket_item1) { create(:basket_item, item: item1, basket: basket, quantity: 2) }

      it "returns $54.37" do
        get :checkout, params: { id: basket.id }
        expect(response).to have_http_status(:ok)

        expect(json_body).to eq(
          "invoice" => {
            "final_cost" => 54.37,
            "discount" => -16.47,
            "delivery_fees" => 4.95,
            "init_cost" => 65.9
          }
        )
      end
    end

    context "example 3" do
      let!(:basket_item1) { create(:basket_item, item: item1, basket: basket) }
      let!(:basket_item2) { create(:basket_item, item: item2, basket: basket) }

      it "returns $60.85" do
        get :checkout, params: { id: basket.id }
        expect(response).to have_http_status(:ok)

        expect(json_body).to eq(
          "invoice" => {
            "final_cost" => 60.85,
            "discount" => 0,
            "delivery_fees" => 2.95,
            "init_cost" => 57.9
          }
        )
      end
    end

    context "example 4" do
      let!(:basket_item1) { create(:basket_item, item: item1, basket: basket, quantity: 3) }
      let!(:basket_item2) { create(:basket_item, item: item3, basket: basket, quantity: 2) }

      it "returns $98.27" do
        get :checkout, params: { id: basket.id }
        expect(response).to have_http_status(:ok)

        expect(json_body).to eq(
          "invoice" => {
            "final_cost" => 98.27,
            "discount" => -16.47,
            "delivery_fees" => 0,
            "init_cost" => 114.75
          }
        )
      end
    end
  end
end
