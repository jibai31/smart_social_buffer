# encoding: UTF-8
class BufferedPostsController < ApplicationController
  load_and_authorize_resource through: :current_user

  def index
  end

  def destroy
    @buffered_post.destroy
    redirect_to timeline_path
  end

  def fill
    MessageBufferizer.new(current_user).perform
    redirect_to timeline_path
  end

  private

  def buffered_post_params
    params.require(:buffered_post).permit(:message, :run_at, :state)
  end
end
