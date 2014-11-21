# encoding: UTF-8
class PlanningsController < ApplicationController
  before_action :load_accounts

  # For show action
  load_and_authorize_resource :account, only: [:show]
  load_and_authorize_resource :planning, through: :account, singleton: true, only: [:show]
  # For index actions
  load_and_authorize_resource only: [:index]

  def index
    @planning = @accounts.first.planning
    initialize_planning
    render :show
  end

  def show
    @planning = @account.planning
    initialize_planning
  end

  private

  def load_accounts
    @accounts = current_user.accounts
    initialize_plannings
  end

  def initialize_plannings
    @accounts.each do |account|
      account.create_planning if account.planning.nil?
    end
  end

  def initialize_planning
    buffered_weeks = @planning.buffered_weeks.to_a
    while buffered_weeks.size < 4
      buffered_weeks << @planning.buffered_weeks.build
    end
  end
end
