# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#
puts "Populating database with users..."

User.create!(
  [
    username: "aniwhistler",
    email: "aniwhistler@gmail.com",
    password: "123456",
    dislikes: "Eggplant, mushy textured food, blue-cheese",
    preferences: "Pasta, sweet drinks, not too much sugar, garlic"
  ]
)

puts "...finished with users"

puts "Populating database with recipes..."

puts "...finished with recipes"

puts "Populating database with allergies..."

puts "...finished with allergies"

puts "Populating database with conditions..."

puts "...finished with conditions"
