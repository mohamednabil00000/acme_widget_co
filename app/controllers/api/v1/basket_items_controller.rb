# frozen_string_literal: true

class Api::V1::BasketItemsController < Api::BaseController
  # GET /api/v1/baskets/:basket_id/basket_items
  def index
    basket_items = BasketItem.where(basket_id: params[:basket_id]).
                              includes(:item).
                              paginate(page: page_no, per_page: per_page)

    render json: { basket_items: BasketItemSerializer.collection(basket_items) }
  end
end
