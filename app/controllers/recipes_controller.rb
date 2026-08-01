class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
    @banner = Rails.cache.fetch("recipe_banner_#{@recipe.id}", expires_in: 1.hour) do
      RecipeApiService.fetch_recipe_banner(@recipe)
    end

    if @recipe.chat_id.present?
    @target_chat = Chat.find(@recipe.chat_id)
    else
    @target_chat = Chat.new(user: current_user, title: "Chat about #{@recipe.title}")
    end
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to recipe_path(@recipe)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def test_create
    message = Message.find(params[:message_id])
    num = params[:recipe_index].to_i
    hash_response = message.recipes[num]
    chat = message.chat_id
    # example_response = {"assistant_reply"=>"SIGH* You again? Fine, here's some chicken recipes. Try not to mess them up.", "recipes"=>[{"title"=>"Garlic Herb Roast Chicken", "description"=>"A flavorful roasted chicken seasoned with garlic and herbs.", "ingredients"=>"1 whole chicken, garlic, rosemary, thyme, olive oil, salt, pepper", "instructions"=>"Preheat oven to 375°F. Rub chicken with garlic, herbs, olive oil, salt, and pepper. Roast for 1.5 hours.", "calories"=>450, "cook_time"=>90, "difficulty"=>2, "prep_time"=>15, "rating"=>4, "servings"=>4}, {"title"=>"Spicy Chicken Stir-Fry", "description"=>"A quick and spicy stir-fry with vegetables and chicken slices.", "ingredients"=>"500g chicken breast, bell peppers, soy sauce, chili flakes, garlic, ginger, vegetable oil", "instructions"=>"Slice chicken and vegetables. Stir-fry garlic and ginger, add chicken until cooked, then add vegetables and sauces. Cook until tender.", "calories"=>350, "cook_time"=>20, "difficulty"=>1, "prep_time"=>10, "rating"=>4, "servings"=>2}, {"title"=>"Chicken Alfredo Pasta", "description"=>"Creamy Alfredo sauce with tender chicken and pasta.", "ingredients"=>"200g pasta, chicken breast, heavy cream, parmesan cheese, garlic, butter, salt, pepper", "instructions"=>"Cook pasta. Sauté chicken with garlic and butter. Add cream and cheese, combine with pasta.", "calories"=>700, "cook_time"=>30, "difficulty"=>2, "prep_time"=>10, "rating"=>3, "servings"=>2}]}

    # {
    #   "assistant_reply"=>"Ok, here are the 3 recipes for hot dogs!",
    #   "recipes"=>[
    #   {"title"=>"Classic Chicago-Style Hot Dog",
    #   "description"=>"A traditional Chicago-style hot dog topped with mustard, relish, onions, tomato slices, pickles, and sport peppers in a poppy seed bun.",
    #   "ingredients"=>"Beef hot dogs, poppy seed buns, yellow mustard, sweet relish, chopped onions, tomato slices, pickle spears, sport peppers, celery salt.",
    #   "instructions"=>"Grill the hot dogs until cooked through. Place in buns and top with mustard, relish, onions, tomatoes, pickles, peppers, and a sprinkle of celery salt.",
    #   "calories"=>350,
    #   "cook_time"=>10,
    #   "difficulty"=>2,
    #   "prep_time"=>5,
    #   "rating"=>4,
    #   "servings"=>4},

    #   {"title"=>"New York Style Hot Dog",
    #   "description"=>"A simple yet flavorful hot dog with mustard and sauerkraut on a steamed bun.",
    #   "ingredients"=>"Beef hot dogs, hot dog buns, yellow mustard, sauerkraut.",
    #   "instructions"=>"Cook hot dogs on a grill or boil until heated through. Steam the buns. Place hot dogs in buns and top with mustard and sauerkraut.",
    #   "calories"=>330,
    #   "cook_time"=>10,
    #   "difficulty"=>1,
    #   "prep_time"=>5,
    #   "rating"=>4,
    #   "servings"=>4},

    #   {"title"=>"Chili Cheese Hot Dog",
    #   "description"=>"A hearty hot dog topped with chili and melted cheese, perfect for a filling snack.",
    #   "ingredients"=>"Beef hot dogs, hot dog buns, chili (prepared), shredded cheddar cheese.",
    #   "instructions"=>"Cook hot dogs as desired. Fill buns with hot dogs, spoon chili over, and sprinkle with cheese. Melt the cheese under a broiler if needed.",
    #   "calories"=>500,
    #   "cook_time"=>15,
    #   "difficulty"=>2,
    #   "prep_time"=>5,
    #   "rating"=>4,
    #   "servings"=>4}
    # ]
    # }

    # Recipe.create!(
    #   title:        hash_response["title"],
    #   calories:     hash_response["calories"],
    #   cook_time:    hash_response["cook_time"],
    #   prep_time:    hash_response["prep_time"],
    #   servings:     hash_response["servings"],
    #   difficulty:   hash_response["difficulty"],
    #   ingredients:  hash_response["ingredients"],
    #   instructions: hash_response["instructions"],
    #   description:  hash_response["description"],
    #   rating:       hash_response["rating"],
    #   user_id:      current_user.id
    # )
    if Recipe.exists?(title: hash_response&.dig("title"), ingredients: hash_response&.dig("ingredients"), instructions: hash_response&.dig("instructions"))
      redirect_back fallback_location: root_path, notice: "Recipe already exists!"
    else

      if hash_response.blank?
        redirect_back fallback_location: root_path, alert: "AI Generation failed: The model returned an empty response."
        return # Crucial: stops execution so the code below never runs
      end
    @recipe = Recipe.new(
      title:        hash_response["title"],
      calories:     hash_response["calories"],
      cook_time:    hash_response["cook_time"],
      prep_time:    hash_response["prep_time"],
      servings:     hash_response["servings"],
      difficulty:   hash_response["difficulty"],
      ingredients:  hash_response["ingredients"],
      instructions: hash_response["instructions"],
      description:  hash_response["description"],
      rating:       hash_response["rating"],
      user_id:      current_user.id,
      chat_id:      chat
    )

    if @recipe.save
  redirect_to recipe_path(@recipe), notice: "Test recipe created successfully!"
    else
  missing_fields = @recipe.errors.full_messages.to_sentence
  redirect_back fallback_location: root_path, alert: "AI Generation failed: #{missing_fields}"
    end

    # redirect_to recipe_path(@recipe), notice: "Test recipe created successfully!"
    end
  end


  def update_recipe
    @recipe = Recipe.find(params[:recipe_id])
    @message = Message.find(params[:message_id])
    updated_recipe_data = @message.recipes[params[:recipe_index].to_i]
    chat = @message.chat_id

    if updated_recipe_data.blank?
      redirect_back fallback_location: recipe_path(@recipe), alert: "AI Update failed: The model returned no data."
      return
    end

    @recipe.assign_attributes(
      title:        updated_recipe_data["title"],
      calories:     updated_recipe_data["calories"],
      cook_time:    updated_recipe_data["cook_time"],
      prep_time:    updated_recipe_data["prep_time"],
      servings:     updated_recipe_data["servings"],
      difficulty:   updated_recipe_data["difficulty"],
      ingredients:  updated_recipe_data["ingredients"],
      instructions: updated_recipe_data["instructions"],
      description:  updated_recipe_data["description"],
      rating:       updated_recipe_data["rating"],
      user_id:      current_user.id,
      chat_id:      chat

    )


    if @recipe.save
      redirect_to recipe_path(@recipe), notice: "Recipe updated successfully via AI!"
    else
      missing_fields = @recipe.errors.full_messages.to_sentence
      redirect_back fallback_location: recipe_path(@recipe), alert: "AI Update failed: #{missing_fields}"
    end
      # redirect_to recipe_path(@recipe), notice: "Recipe successfully updated by AI!"

  end


  private

  def recipe_params
    params.require(:recipe).permit(:title, :description, :instructions, :ingredients, :calories, :cook_time, :prep_time, :servings, :difficulty, :rating, :user_id)
  end
end
