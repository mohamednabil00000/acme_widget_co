# frozen_string_literal: true

class Api::V1::BasketItems::CreateContract < ApplicationContract
  params do
    required(:product_code).filled(:string)
    optional(:quantity).value(:integer, gteq?: 1)
  end
end
