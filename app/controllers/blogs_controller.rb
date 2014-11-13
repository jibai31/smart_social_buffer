# encoding: UTF-8
class BlogsController < ApplicationController
  load_and_authorize_resource
  layout "contents"

  def edit
  end

  def create
    @blog = current_user.blogs.build(blog_params)
    if @blog.save
      redirect_to @blog
    else
      render 'devise/registrations/edit', alert: "Error!"
    end
  end

  def update
    if @blog.update(blog_params)
      redirect_to @blog
    else
      render :edit
    end
  end

  def destroy
    @blog.destroy
    redirect_to contents_path
  end

  def import
    if FeedImporter.new(@blog).perform
      redirect_to @blog, notice: "Blog posts successfully imported"
    else
      redirect_to @blog, alert: "<strong>Something went wrong!</strong> Please verify the blog URL"
    end
  end

  private

  def blog_params
    params.require(:blog).permit(:name, :url, :category_id)
  end
end
