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
    if @account
      @planning = @account.planning
      @planning.initialize_coming_weeks
    end
    render :show
  end

  def show
    @planning.initialize_coming_weeks
  end

  private

  def load_accounts
    @accounts = current_user.accounts.implemented
  end
end
