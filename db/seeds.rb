# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Recipe.create!(
  title: "Donuts",
  description: "Delicious doughy treats",
  instructions: "Mix dough and stuff and mix dough and stuff and mix dough and stuff and mix dough and stuff and mix dough and stuff and mix dough and stuff and mix dough and stuff and mix dough and stuff and ",
  difficulty: 3,
  rating: 3,
  servings: 3,
  calories: 3000,
  prep_time: 20,
  cook_time: 20,
  user_id: 1
)
