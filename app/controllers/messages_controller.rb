# encoding: UTF-8
class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  load_and_authorize_resource :content
  load_resource
  layout "contents"

  def index
    # Not implemented
  end

  def show
    # Not implemented
  end

  def new
    @message = @content.messages.build(post_only_once: @content.post_only_once)
  end

  def edit
  end

  def create
    @message = @content.messages.build(message_params)
    if @message.save
      redirect_to contents_path
    else
      render :new
    end
  end

  def update
    if @message.update(message_params)
      redirect_to contents_path
    else
      render :edit
    end
  end

  def destroy
    @message.destroy
  end

  private
    def set_message
      @message = Message.find(params[:id])
    end

    def message_params
      params.require(:message).permit(:content_id, :text, :social_network, :post_counter, :last_posted_at, :post_only_once)
    end
end
