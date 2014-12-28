module PlanningsHelper

  def preview_path(account, week, args = {})
    account_buffered_week_preview_path(account, week, args)
  end

  def plan_path(account, week, args = {})
    account_buffered_week_plan_path(account, week, args)
  end
end
