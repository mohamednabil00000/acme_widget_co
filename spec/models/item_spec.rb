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
end
