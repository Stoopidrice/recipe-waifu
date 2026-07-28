class SingleRecipeSchema < RubyLLM::Schema
    string :title
    string :description
    string :ingredients
    string :instructions
    integer :calories
    integer :cook_time
    integer :difficulty
    integer :prep_time
    integer :rating
    integer :servings
end

class RecipeSchema < RubyLLM::Schema
  string :assistant_reply

  array :recipes, of: SingleRecipeSchema
end
