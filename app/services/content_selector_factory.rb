# encoding: utf-8
class ContentSelectorFactory < SocialServiceFactory

  def build
    "#{provider}ContentSelector".constantize.new(account)
  end

end
