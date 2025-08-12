# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::BasketsController, type: :routing do
  describe "routing" do
    it "routes to #create" do
      expect(post: "/api/v1/baskets").to route_to("api/v1/baskets#create")
    end
  end
end
