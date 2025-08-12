# frozen_string_literal: true

class Api::V1::BasketItemsController < Api::BaseController
  before_action :set_basket, only: %i[ create ]
  before_action :set_item, only: %i[ create ]

  # GET /api/v1/baskets/:basket_id/basket_items
  def index
    basket_items = BasketItem.where(basket_id: params[:basket_id]).
                              includes(:item).
                              paginate(page: page_no, per_page: per_page)

    render json: { basket_items: BasketItemSerializer.collection(basket_items) }
  end

  # POST /api/v1/baskets/:basket_id/basket_items
  def create
    req = Api::V1::BasketItems::CreateContract.check(basket_item_params)
    if req.errors.present?
      return render json: { errors: req.errors.to_h }, status: :unprocessable_entity
    end

    result = BasketItems::AddService.call(
      basket: @basket,
      item: @item,
      basket_item_params: req.to_h.except(:product_code)
    )

    if result.success?
      render json: { basket_item: BasketItemSerializer.item(result.payload) }, status: :created
    else
      render json: { errors: result.error }, status: :bad_request
    end
  end

  private

  def basket_item_params
    params.require(:basket_item).permit(:product_code, :quantity)
  end

  def set_basket
    @basket = Basket.find_by(id: params[:basket_id])
    unless @basket
      render json: { error: "Basket is not found." }, status: :not_found
    end
  end

  def set_item
    @item = Item.find_by(code: basket_item_params[:product_code])
    unless @item
      render json: { error: "Item is not found." }, status: :not_found
    end
  end
end
