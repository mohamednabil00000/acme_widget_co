# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::ItemsController, type: :controller do
  describe "GET #index" do
    let!(:item1) { create(:item, code: "as1") }
    let!(:item2) { create(:item, code: "as2") }

    let(:json_body) { JSON.parse(response.body) }

    context "with per page eq 10" do
      it "fetch first page" do
        get :index, params: { per_page: 10, page: 1 }
        expect(json_body["items"].size).to eq 2
        expect(json_body["items"]).to match_array(
          [
            {
              "id" => item1.id,
              "name" => item1.name,
              "code" => item1.code,
              "price" => item1.price.to_f
            },
            {
              "id" => item2.id,
              "name" => item2.name,
              "code" => item2.code,
              "price" => item2.price.to_f
            }
          ]
        )
      end
    end

    context "with per page eq 1" do
      it "fetch first page" do
        get :index, params: { per_page: 1, page: 1 }
        expect(json_body["items"].size).to eq 1
        expect(json_body["items"]).to match_array(
          [
            {
              "id" => item1.id,
              "name" => item1.name,
              "code" => item1.code,
              "price" => item1.price.to_f
            }
          ]
        )
      end
    end
  end
end
