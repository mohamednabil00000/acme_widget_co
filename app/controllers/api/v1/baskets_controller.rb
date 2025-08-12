# frozen_string_literal: true

class Api::V1::BasketsController < Api::BaseController
  # POST /api/v1/baskets
  def create
    result = Baskets::CreateService.call
    if result.success?
      render json: { basket: BasketSerializer.item(result.payload) }, status: :created
    else
      render json: { errors: result.error }, status: :bad_request
    end
  end
end
