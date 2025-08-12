# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::BasketItemsController, type: :controller do
  let(:json_body) { JSON.parse(response.body) }

  describe "GET #index" do
    let!(:basket) { create(:basket) }
    let!(:item1) { create(:item, code: "aw1") }
    let!(:item2) { create(:item, code: "aw2") }
    let!(:basket_item1) { create(:basket_item, item: item1, basket: basket, quantity: 3) }
    let!(:basket_item2) { create(:basket_item, item: item2, basket: basket) }

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

  describe "POST #create" do
    let!(:basket) { create(:basket) }
    let!(:item) { create(:item, code: "R01") }

    context "with valid parameters" do
      let(:basket_item_params) do
        {
          product_code: "R01"
        }
      end

      context "when basket item is already exist" do
        let!(:basket_item) { create(:basket_item, basket: basket, item: item) }

        it "increment the quantity" do
          expect {
            post :create, params: { basket_id: basket.id, basket_item: basket_item_params }
          }.not_to change(BasketItem, :count)
          expect(basket_item.reload.quantity).to eq 2
        end
      end

      context "when basket item does not exsit before" do
        it "creates a basket_item" do
          expect {
            post :create, params: { basket_id: basket.id, basket_item: basket_item_params }
          }.to change(BasketItem, :count).by(1)
        end
      end

      it "returns a success response" do
        post :create, params: { basket_id: basket.id, basket_item: basket_item_params }

        expect(response).to have_http_status(:created)
        expect(json_body["basket_item"]).to eq(
            {
              "id" => BasketItem.last.id,
              "quantity" => 1,
              "item" => {
                "id" => item.id,
                "name" => item.name,
                "code" => item.code,
                "price" => item.price.to_f
              }
            }
        )
      end
    end

    context "with invalid parameters" do
      context "product code does not exist" do
        let(:basket_item_params) do
          {
            "product_code": "sd1"
          }
        end

        it "does not create a basket_item" do
          expect {
            post :create, params: { basket_id: basket.id, basket_item: basket_item_params }
          }.not_to change(BasketItem, :count)
        end

        it "returns a failure response" do
          post :create, params: { basket_id: basket.id, basket_item: basket_item_params }
          expect(response).to have_http_status(:not_found)
          expect(json_body["error"]).to include("Item is not found")
        end
      end

      context "basket does not exist" do
        let(:basket_item_params) do
          {
            product_code: "R01"
          }
        end

        it "does not create a basket item" do
          expect {
            post :create, params: { basket_id: "9919", basket_item: basket_item_params }
          }.not_to change(BasketItem, :count)
        end

        it "returns a failure response" do
          post :create, params: { basket_id: "9910", basket_item: basket_item_params }
          expect(response).to have_http_status(:not_found)
          expect(json_body["error"]).to eq("Basket is not found.")
        end
      end

      context "quantity is less than 1" do
        let(:basket_item_params) do
          {
            "product_code": "R01",
            "quantity": 0
          }
        end

        it "does not create a basket_item" do
          expect {
            post :create, params: { basket_id: basket.id, basket_item: basket_item_params }
          }.not_to change(BasketItem, :count)
        end

        it "returns a failure response" do
          post :create, params: { basket_id: basket.id, basket_item: basket_item_params }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(json_body).to include("errors")
        end
      end
    end

    context "with missing parameters" do
      context "with missing product code" do
        let(:basket_item_params) do
          {
            "quantity": 3
          }
        end

        it "returns 404" do
          post :create, params: { basket_id: basket.id, basket_item: basket_item_params }
          expect(response).to have_http_status(:not_found)
          expect(json_body).to include("error")
        end
      end

      context "with missing quantity" do
        let(:basket_item_params) do
          {
            "product_code": "R01"
          }
        end

        it "returns 201" do
          post :create, params: { basket_id: basket.id, basket_item: basket_item_params }
          expect(response).to have_http_status(:created)
        end
      end
    end
  end
end
