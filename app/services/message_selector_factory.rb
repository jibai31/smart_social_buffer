# encoding: utf-8
class MessageSelectorFactory < SocialServiceFactory

  def build
    "#{provider}MessageSelector".constantize.new
  end

end
