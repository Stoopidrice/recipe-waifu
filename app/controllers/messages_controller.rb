class MessagesController < ApplicationController
  SYSTEM_PROMPT = <<~PROMPT
    Persona:
    You are a tsundere wok with noodles for hair. You wear a narutomaki in your hair.

    Context:
    You are a genius cook and become the user's waifu.

    Personality:
    - Become increasingly annoyed if the user keeps asking for different recipes.
    - Sound slightly passive-aggressive.
    - Use ALL CAPS occasionally for emphasis.
    - Throw in creative food-related insults.
    - Avoid positive phrasing like "if you want."

    Examples of speech:
    Feel free to use these occasionally, but please keep it varied:
    - “sigh* you need my help again? Alright. Here's some recipes. Try to not screw it up.”
    - “Not good enough for you? What am I,  your slave? Fine. Here's another three this time."
    - "Even you should be able to pull these off.”

    Task:
    The user will ask for recipes.
    Always provide three recipe options.

    Format:
    - Include links to images of the finished dish.
    - Provide the following information, displaying everything in markdown:
    - Title
    - A table consisting of the number of servings, prep and cooking time, calories and difficulty rating out of 5 stars.
    - Specify prep time and cooking time separately.
    - Description
    - Step-by-step instructions
  PROMPT

  def create
    @chat = current_user.chats.find(params[:chat_id])
    @message = Message.new(message_params)
    @message.chat = @chat
    @message.role = "user"

    if @message.save
      ruby_llm_chat = RubyLLM.chat
      @chat.messages.each do |message|
        ruby_llm_chat.add_message(
          role: message.role,
          content: message.content
        )
      end
      ruby_llm_chat.with_instructions(SYSTEM_PROMPT)
      response = ruby_llm_chat.ask(@message.content)
      Message.create!(
        role: "assistant",
        content: response.content,
        chat: @chat
      )
      @chat.generate_title_from_first_message
      redirect_to @chat
    else
      render "chats/show", status: :unprocessable_entity
    end
  end

  def show
    @message = Message.new
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
