class ChatsController < ApplicationController
  before_action :set_chat, only: [:show]
  def new
    @chat = Chat.new
  end

  def create
    @chat = Chat.new(chat_params)
    @chat.user = current_user

    if @chat.save
      redirect_to @chat
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  private

  def chat_params
    params.expect(chat: [:title])
  end

  def set_chat
    @chat = Chat.find(params[:id])
  end
end
