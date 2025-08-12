# frozen_string_literal: true

module Paginatable
  extend ActiveSupport::Concern

  class_methods do
    def paginate(page: 1, per_page: 10)
      page = [ page.to_i, 1 ].max
      per_page = [ per_page.to_i, 1 ].max
      offset = (page - 1) * per_page

      limit(per_page).offset(offset)
    end
  end
end
