# frozen_string_literal: true

class Api::V1::BasketsController < Api::BaseController
  before_action :set_basket, only: %i[ checkout ]

  # POST /api/v1/baskets
  def create
    result = Baskets::CreateService.call
    if result.success?
      render json: { basket: BasketSerializer.item(result.payload) }, status: :created
    else
      render json: { errors: result.error }, status: :bad_request
    end
  end

  # GET /api/v1/baskets/:id/checkout
  def checkout
    result = Baskets::CheckoutService.call(basket: @basket)
    render json: { invoice: result.payload }, status: :ok
  end

  private

  def set_basket
    @basket = Basket.find(params[:id])
  end
end
