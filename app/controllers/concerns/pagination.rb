# frozen_string_literal: true

module Pagination
  extend ActiveSupport::Concern

  def default_per_page
    10
  end

  def page_no
    params[:page]&.to_i || 1
  end

  def per_page
    params[:per_page]&.to_i || default_per_page
  end
end
