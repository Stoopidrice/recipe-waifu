class PagesController < ApplicationController
  def home
    @recipes = Recipe.all
  end
end
