# encoding: utf-8
class WeekLoadBalancerFactory < SocialServiceFactory

  def build(week, today = Date.today)
    "#{provider}WeekLoadBalancer".constantize.new(week, account, today)
  end

end
