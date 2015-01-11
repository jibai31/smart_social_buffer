# encoding: UTF-8
class ContentsController < ApplicationController
  load_and_authorize_resource through: :current_user

  def index
    @contents = current_user.contents_with_messages.order(created_at: :desc)
    if filter_category_id = params[:category_id]
      @contents = @contents.where(category_id: filter_category_id)
    end
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    success = @content.save
    respond_to do |format|
      format.html { success ? redirect_to(contents_path) : render(:new) }
      format.js
    end
  end

  def update
    if @content.update(content_params)
      redirect_to contents_path
    else
      render :edit
    end
  end

  def destroy
    @content.destroy
    respond_to do |format|
      format.html { redirect_to contents_path }
      format.js
    end
  end

  private

  def content_params
    params.require(:content).permit(:title, :url, :activated, :post_only_once, :category_id, :blog_id, :posts_count)
  end
end
