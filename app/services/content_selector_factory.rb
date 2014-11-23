# encoding: utf-8
class ContentSelectorFactory < SocialServiceFactory

  def build(week_load_balancer)
    "#{provider}ContentSelector".constantize.new(account, week_load_balancer)
  end

end
