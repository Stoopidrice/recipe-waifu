class RecipeApiService
  def self.fetch_banner
    url = "https://apis.scrimba.com/unsplash/photos/random?orientation=landscape&query=movies"
    response = Faraday.get(url)
    data = JSON.parse(response.body)
    data&.dig("urls", "regular") || "fallback.jpg"
  end

  def self.try_banner
    return "fallback.jpg"
  end

  def self.fetch_recipe_banner(recipe)
    response = Faraday.get("https://apis.scrimba.com/unsplash/photos/random?orientation=landscape&query=#{recipe.title}")
    data = JSON.parse(response.body)
    data&.dig("urls", "regular") || "fallback.jpg"
  end


  def self.fetch_card_banner(recipes, index)
    response = Faraday.get("https://apis.scrimba.com/unsplash/photos/random?orientation=landscape&query=#{recipes["recipes"][index]["title"]}")
    data = JSON.parse(response.body)
    data&.dig("urls", "regular") || "fallback.jpg"
  end
end
