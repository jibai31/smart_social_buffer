# encoding: utf-8
class SocialServiceFactory

  def initialize(account)
    @account = account
  end

  attr_reader :account

  private

  def provider
    @provider ||= account.social_network
  end

end
