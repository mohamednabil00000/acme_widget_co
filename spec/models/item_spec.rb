# frozen_string_literal: true

require "rails_helper"

RSpec.describe Item, type: :model do
  describe "validations" do
    subject { build(:item) }

    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(100) }
    it { should validate_presence_of(:code) }
    it { should validate_uniqueness_of(:code) }
    it { should validate_presence_of(:price) }
  end

  describe "associations" do
    it { should have_many(:basket_items).dependent(:destroy_async).inverse_of(:item) }
    it { should have_many(:baskets).through(:basket_items) }
  end

  describe 'pagination' do
    before do
      # Create 25 items for testing pagination
      25.times do |i|
        Item.create!(
          name: "Item #{i + 1}",
          code: "CODE#{i + 1}",
          price: (i + 1) * 10.0
        )
      end
    end

    it 'paginates results correctly' do
      expect(Item.paginate(page: 1, per_page: 10).count).to eq(10)
      expect(Item.paginate(page: 2, per_page: 10).count).to eq(10)
      expect(Item.paginate(page: 3, per_page: 10).count).to eq(5)
    end

    it 'handles invalid page numbers gracefully' do
      expect(Item.paginate(page: 0, per_page: 10).count).to eq(10)
      expect(Item.paginate(page: -1, per_page: 10).count).to eq(10)
    end

    it 'handles invalid per_page values gracefully' do
      expect(Item.paginate(page: 1, per_page: 0).count).to eq(1)
      expect(Item.paginate(page: 1, per_page: -5).count).to eq(1)
    end
  end
end
