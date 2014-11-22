# encoding: utf-8
class WeekLoadBalancerFactory < SocialServiceFactory

  def build(week)
    "#{provider}WeekLoadBalancer".constantize.new(week, account)
  end

end
