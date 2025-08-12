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
end
