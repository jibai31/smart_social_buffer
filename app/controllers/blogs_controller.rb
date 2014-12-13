# encoding: UTF-8
class BlogsController < ApplicationController
  load_and_authorize_resource
  layout "contents"

  def edit
  end

  def create
    if create_blog
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

  def autoimport
    create_blog
    if FeedImporter.new(@blog).perform
      redirect_to :back, notice: "#{@blog.contents.count} blog articles successfully imported"
    else
      @blog.destroy
      redirect_to :back, alert: "<strong>Something went wrong!</strong> Please verify the blog URL"
    end
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

  def create_blog
    @blog = current_user.blogs.build(blog_params)
    @blog.category_id = 1 if @blog.category_id.nil?
    @blog.save
  end
end
