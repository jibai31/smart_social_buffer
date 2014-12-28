# encoding: utf-8
class HomePresenter
  include PlanningsHelper
  include Rails.application.routes.url_helpers

  def initialize(user)
    @user = user
    @account = user.accounts.implemented.first
    @blog = user.blogs.own_content.first

    if @account
      @planning = @account.planning
      @week = late_in_the_week ? @planning.next_week : @planning.current_week
    else
      @planning = Planning.new
      @week = BufferedWeekFactory.new(@planning).build
    end
    @full_planning = @week.posts_count > 0
    @week_id = @week.id
  end

  attr_reader :user, :account, :blog, :planning, :week, :week_id, :full_planning

  # Step 1: connect account

  def connect_account_class
    'done' if account
  end

  def connect_account_text
    account ? "Connected with #{account.name}" : "Connect your Twitter account"
  end

  def connect_account_btn
    account ? "Connected" : "Connect Twitter"
  end

  def connect_account_btn_class
    account ? "btn-default disabled" : "btn-primary"
  end

  # Step 2: add your blog

  def add_blog_class
    !account ? 'next' : ('done' if blog) 
  end

  def add_blog_placeholder
    blog ? blog.url : "Eg, blog.mycompany.com"
  end

  def add_blog_input_disabled?
    !account || blog
  end

  def add_blog_btn
    blog ? "Blog added" : "Add a blog"
  end

  def add_blog_btn_class
    add_blog_input_disabled? ? "btn-default disabled" : "btn-primary"
  end

  # Step 3: preview planning

  def preview_class
    (!account || !blog) ? 'next' : ('done' if full_planning)
  end

  def preview_btn_id
    account ? "jsPreviewWeek#{week_id}" : ""
  end

  def preview_btn_class
    account ? "btn-primary" : "btn-default disabled"
  end

  def preview_btn_path
    account ? preview_path(account, week, hidebuttons: 1) : '#'
  end

  # Step 4: save planning

  def save_btn_id
    account ? "jsPlanWeek#{week_id}" : ""
  end

  def save_btn_class
    account ? "btn-danger js-plan" : ""
  end

  def save_btn_path
    account ? plan_path(account, week) : '#'
  end

  private

  def late_in_the_week
    # On Fri, Sat, Sun
    Date.today.cwday > 4
  end
end
