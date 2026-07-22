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

User.create!(
  [
    username: "johno37",
    email: "jhony36@gmail.com",
    password: "123456",
    dislikes: "I don't like bitter foods or chocolate or too much salt or celery",
    preferences: "Love me some great steak and potatoes. Hot sauce and pepper are my go to condiments"
  ]
)

User.create!(
  [
    username: "waifulover420",
    email: "bill-flozner@hotmail.com",
    password: "123456",
    dislikes: "sugar, sweets, junk-food, papayas, cherries",
    preferences: "protein, grains, fiber, sweet potatoes, fruit smoothies, eggs"
  ]
)

puts "...finished with users"

puts "Populating database with recipes..."


Recipe.create!(
  [
    title: "Bacon and Parmesan Penne Pasta",
    calories: 412,
    cook_time: 20,
    prep_time: 10,
    servings: 8,
    difficulty: 4,
    ingredients: "1 (16 ounce) package dry penne pasta, 1 pound bacon, coarsely chopped, 1 large onion, chopped, ¼ cup olive oil, ½ cup grated Parmesan cheese",
    instructions: "Bring a large pot of lightly salted water to a boil. Add penne and cook, stirring occasionally, until tender yet firm to the bite, about 11 minutes. While the pasta is cooking, cook bacon and onion in a large skillet over medium heat, stirring often, until bacon is crisp and onion is beginning to brown, about 10 minutes. Remove from the heat and drain grease into a small container. Drain pasta and transfer to a large serving bowl. Add oil and stir to coat pasta. Add cooked bacon and onion plus 1 to 2 tablespoons bacon grease. Sprinkle Parmesan over pasta and stir until well combined. Add more bacon grease as desired for flavor and moisture.",
    description: "This bacon pasta recipe is so easy to make and so flavorful, you'll want to make it a part of your regular dinner routine. It's a great option for bacon lovers and those who want something other than red sauce on their pasta.",
    rating: 4,
    user_id: 1
  ]
)

Recipe.create!(
  [
    title: "Vegetable Quinoa Pilaf",
    calories: 195,
    cook_time: 20,
    prep_time: 30,
    servings: 3,
    difficulty: 3,
    ingredients: "1 tablespoon olive oil, ½ onion, chopped, 1 stalk celery, chopped, 2 carrots, diced, ½ cup quinoa, 1 cup hot water, 1 bay leaf, 1 tablespoon lemon zest, 1 tablespoon lemon juice, ½ cup frozen green peas, thawed, salt to taste, ground black pepper to taste",
    instructions: "Pour oil into a medium saucepan, and place over medium heat. Add onion, celery, and carrots; cook and stir for 10 minutes, or until vegetables are tender. Using a strainer, rinse quinoa under cold water. Drain well. Stir into the vegetables; cook and stir for 1 minute. Add water, bay leaf and lemon rind and juice; bring to boil. Cover, and reduce heat to medium low. Simmer for 15 to 20 minutes, or until liquid is absorbed and quinoa is tender. Discard bay leaf. Stir in peas, and season to taste with salt and pepper. Serve.",
    description: "Quinoa is a delicately flavored grain, native to South America. It can be found in most health food stores. For even more flavorful pilaf, use vegetable stock in place of the water.",
    rating: 3,
    user_id: 3
  ]
)

Recipe.create!(
  [
    title: "Moist Coconut Cake",
    calories: 408,
    cook_time: 60,
    prep_time: 30,
    servings: 12,
    difficulty: 7,
    ingredients: "2 cups all-purpose flour, 1 tablespoon baking powder, 1 teaspoon salt, 1 cup butter, room temperature, 2 cups white sugar, 5 large eggs, room temperature, 1 teaspoon coconut extract, 1 cup buttermilk, room temperature, 1 cup flaked coconut",
    instructions: "Preheat the oven to 350 degrees F (175 degrees C). Grease and flour a 10-inch tube pan (see Cook's Note). Mix flour, baking powder, and salt together in a large bowl; set aside. Beat butter and sugar together in a separate large bowl with an electric mixer until noticeably lighter in color and fluffy. Add eggs, one at a time, allowing each egg to blend into the beaten butter mixture before adding the next. Mix in coconut extract. Pour in flour mixture alternately with buttermilk, mixing until just incorporated. Fold in coconut, mixing just enough to evenly combine. Pour cake batter into prepared pan. Bake in the preheated oven until a toothpick inserted into the cake comes out clean, about 1 hour. If desired, frost cooled cake with your favorite buttercream frosting and sprinkle with flaked coconut.",
    description: "This coconut cake recipe is soooo good! It makes a really moist cake with lots of coconut flavor. I take it to work and it disappears fast. I bake it in a Bundt pan but you can bake it in two 9-inch cake pans and layer it with your favorite frosting and flaked coconut.",
    rating: 5,
    user_id: 1
  ]
)

puts "...finished with recipes"

puts "Populating database with allergies..."

Allergy.create!(
  [
    name: "nut"
  ]
)

Allergy.create!(
  [
    name: "gluten"
  ]
)

Allergy.create!(
  [
    name: "eggs"
  ]
)

Allergy.create!(
  [
    name: "shellfish"
  ]
)

Allergy.create!(
  [
    name: "kiwis"
  ]
)

Allergy.create!(
  [
    name: "dairy"
  ]
)

puts "...finished with allergies"

puts "Populating database with conditions..."

Condition.create!(
  [
    allergy_id: 5,
    user_id: 1
  ]
)

Condition.create!(
  [
    allergy_id: 2,
    user_id: 2
  ]
)

Condition.create!(
  [
    allergy_id: 3,
    user_id: 2
  ]
)

puts "...finished with conditions"
