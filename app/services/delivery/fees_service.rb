# frozen_string_literal: true

class Delivery::FeesService < BaseService
  def initialize(total_cost:)
    @total_cost = total_cost
  end

  def call
    fees = case total_cost
    when ->(x) { x < 50 }
             4.95
    when ->(x) { x >= 90 }
             0
    else
             2.95
    end
    success(fees)
  end

  private

  attr_accessor :total_cost
end
