# frozen_string_literal: true

require "rails_helper"

RSpec.describe BasketItem, type: :model do
  describe "associations" do
    it { should belong_to(:basket) }
    it { should belong_to(:item) }
  end

  describe "validations" do
    subject { create(:basket_item) }

    it { should validate_presence_of(:quantity) }
    it { should validate_uniqueness_of(:basket_id).ignoring_case_sensitivity.scoped_to(:item_id).with_message("already exist in this basket") }
  end
end
