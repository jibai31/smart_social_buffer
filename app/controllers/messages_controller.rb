# encoding: UTF-8
class MessagesController < ApplicationController
  load_and_authorize_resource :content
  load_and_authorize_resource :message, through: :content
  layout "contents"

  def new
    @available_accounts = current_user.accounts.implemented
    if @available_accounts.count == 0
      flash[:warning] = "You need to connect an account before adding messages."
      redirect_to settings_path and return
    end

    @message = @content.messages.build(
      post_only_once: @content.post_only_once,
      social_network: @available_accounts.first.social_network,
      text: "#{@content.title} #{@content.url}"
    )
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

  def message_params
    params.require(:message).permit(:content_id, :text, :social_network_id, :posts_count, :last_posted_at, :post_only_once)
  end
end
