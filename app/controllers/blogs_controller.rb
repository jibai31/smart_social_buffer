class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  load_and_authorize_resource
  layout "contents"

  def edit
  end

  def create
    @blog = current_user.blogs.build(blog_params)
    if @blog.save
      redirect_to edit_user_registration_path(current_user)
    else
      render 'devise/registrations/edit', alert: "Error!"
    end
  end

  def update
    if @blog.update(blog_params)
      redirect_to edit_user_registration_path(current_user)
    else
      render :edit
    end
  end

  def destroy
    @blog.destroy
  end

  private
    def set_blog
      @blog = Blog.find(params[:id])
    end

    def blog_params
      params.require(:blog).permit(:name, :url, :category_id)
    end
end
