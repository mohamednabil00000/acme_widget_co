# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Product.find_or_create_by!(code: "R01") do |product|
  product.name = "Red Widget"
  product.price = "32.95"
end

Product.find_or_create_by!(code: "G01") do |product|
  product.name = "Green Widget"
  product.price = "24.95"
end

Product.find_or_create_by!(code: "B01") do |product|
  product.name = "Blue Widget"
  product.price = "7.95"
end
