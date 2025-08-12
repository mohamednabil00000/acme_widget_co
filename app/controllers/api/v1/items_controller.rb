# frozen_string_literal: true

class Api::V1::ItemsController < Api::BaseController
  # GET /api/v1/items
  def index
    items = Item.paginate(page: page_no, per_page: per_page)

    render json: { items: ItemSerializer.collection(items) }
  end
end
