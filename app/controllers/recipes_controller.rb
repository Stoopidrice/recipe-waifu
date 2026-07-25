class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
    @banner = Rails.cache.fetch("recipe_banner_#{@recipe.id}", expires_in: 1.hour) do
      RecipeApiService.fetch_recipe_banner(@recipe)
    end
  end

  def new
    @recipe = Recipe.new
  end

  def create
  end
end
