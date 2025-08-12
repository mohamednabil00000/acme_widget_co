# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    code { Faker::Lorem.characters(number: 3) }
    price { Faker::Commerce.price }
  end
end
