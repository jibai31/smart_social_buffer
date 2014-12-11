# encoding: utf-8
class DayPlannerFactory < SocialServiceFactory

  def build(message_selector)
    "#{provider}DayPlanner".constantize.new(account, message_selector)
  end

end
