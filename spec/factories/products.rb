# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    code { Faker::Lorem.characters(number: 3) }
    price { Faker::Commerce.price }
  end
end
