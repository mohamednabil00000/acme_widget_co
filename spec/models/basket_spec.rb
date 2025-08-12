# frozen_string_literal: true

require "rails_helper"

RSpec.describe Basket, type: :model do
  describe "associations" do
    it { should have_many(:basket_items).dependent(:destroy_async).inverse_of(:basket) }
    it { should have_many(:items).through(:basket_items) }
  end
end
