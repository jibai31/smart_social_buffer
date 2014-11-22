# encoding: utf-8
class DayLoadBalancerFactory < SocialServiceFactory

  def build
    "#{provider}DayLoadBalancer".constantize.new
  end

end
