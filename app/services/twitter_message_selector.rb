# encoding: utf-8
class TwitterMessageSelector

  def initialize(account)
    @account = account
  end

  attr_reader :account

  def best_message(content)
    content.messages_on(social_network).less_posted
  end

  def social_network
    account.provider
  end
end
