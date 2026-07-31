require 'ruby_llm/schema'

RubyLLM.configure do |config|
  config.openrouter_api_key = ENV['OPENROUTER_API_KEY']&.strip
end


# config.openrouter_api_base = ENV['OPENROUTER_API_BASE']&.strip

# config.gemini_api_key = ENV["GEMINI_API_KEY"]
# config.openai_api_base = ENV['OPENROUTER_API_BASE']
#
#
# config.openai_api_base = "https://api.groq.com/openai/v1"
# config.openai_api_base = "https://models.github.ai/inference"
# config.openai_api_base = "https://models.inference.ai.azure.com"
# config.openai_api_base = "https://openrouter.ai/api/v1"

# config.openai_api_key = ENV['OPENAI_API_KEY']&.strip
# config.openai_api_base = ENV['OPENAI_API_BASE']&.strip
