module PlanningsHelper

  def preview_path(account, week)
    account_buffered_week_preview_path(account, week)
  end

  def plan_path(account, week)
    account_buffered_week_plan_path(account, week)
  end
end
