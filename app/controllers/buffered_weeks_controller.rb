# encoding: UTF-8
class BufferedWeeksController < ApplicationController
  load_and_authorize_resource :account
  before_action :load_week

  def preview
    @hide_buttons = params[:hidebuttons]
    WeekPlanner.new(@account, @week).preview
  end

  def plan
    WeekPlanner.new(@account, @week).perform
  end

  private

  def load_week
    @week = BufferedWeek.find(params[:buffered_week_id])
  end

  def buffered_week_params
    params.require(:buffered_week).permit(:first_day)
  end
end
