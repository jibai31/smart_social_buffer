# encoding: UTF-8
class PlanningsController < ApplicationController
  before_action :load_accounts

  # For show action
  load_and_authorize_resource :account, only: [:show]
  load_and_authorize_resource :planning, through: :account, singleton: true, only: [:show]
  # For index actions
  load_and_authorize_resource only: [:index]

  def index
    @account = @accounts.first
    @planning = @account.planning
    initialize_planning
    render :show
  end

  def show
    @planning = @account.planning
    initialize_planning
  end

  private

  def load_accounts
    @accounts = current_user.accounts.implemented
    initialize_plannings
  end

  def initialize_plannings
    @accounts.each do |account|
      account.create_planning if account.planning.nil?
    end
  end

  def initialize_planning
    first_day = Date.today.beginning_of_week
    weeks = @planning.buffered_weeks.where("first_day >= ?", first_day).to_a

    while weeks.size < 4
      monday = first_day + (weeks.size).weeks
      factory = BufferedWeekFactory.new(@planning, monday)
      factory.create
      weeks << factory.week
    end
  end
end
