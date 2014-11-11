class ContentsController < ApplicationController
  before_action :set_content, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @contents = current_user.contents
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @content = current_user.contents.build(content_params)
    if @content.save
      redirect_to contents_path
    else
      render :new
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
  end

  private
    def set_content
      @content = Content.find(params[:id])
    end

    def content_params
      params.require(:content).permit(:title, :url, :activated, :post_only_once, :category_id)
    end
end
