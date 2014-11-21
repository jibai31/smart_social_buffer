# encoding: UTF-8
class PlanningsController < ApplicationController
  load_and_authorize_resource :account, only: [:show]
  load_and_authorize_resource except: [:show]

  def index
  end

  def show
    @planning = @account.planning
  end
end
