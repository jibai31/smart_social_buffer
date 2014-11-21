# encoding: UTF-8
class BufferedPostsController < ApplicationController
  load_and_authorize_resource

  def destroy
    @buffered_post.destroy
    redirect_to plannings_path
  end

  private

  def buffered_post_params
    params.require(:buffered_post).permit(:message, :run_at, :state)
  end
end
