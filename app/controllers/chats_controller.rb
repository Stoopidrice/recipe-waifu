class ChatsController < ApplicationController
  before_action :set_chat, only: [:show]
  DEFAULT_TITLE = "New Chat"
  def new
    @all_chats = Chat.all
    @chat = Chat.new
  end

  def create
    # @chat.title = "New Chat"
    @chat = Chat.new(title: Chat::DEFAULT_TITLE)
    @chat.user = current_user

    if @chat.save
      redirect_to @chat
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @message = Message.new
  end

  private

  def chat_params
    params.expect(chat: [:title])
  end

  def set_chat
    @chat = Chat.find(params[:id])
  end
end
