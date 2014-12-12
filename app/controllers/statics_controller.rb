# encoding: utf-8
class StaticsController < ApplicationController

  def home
    if user_signed_in?
      @account = current_user.accounts.implemented.first
      if @account
        @planning = @account.planning
        @week = @planning.current_week
      else
        @planning = Planning.new
        @week = BufferedWeekFactory.new(@planning).build
      end
      @blog = current_user.blogs.own_content.first
      @full_planning = @week.posts_count > 0
      render :home
    else
      render :landing
    end
  end
end
