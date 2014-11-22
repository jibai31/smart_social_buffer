# encoding: utf-8
class SocialServiceFactory

  def initialize(account)
    @account = account
  end

  attr_reader :account

  private

  def provider
    @provider ||= SocialNetwork.new(account.provider).name
  end

end
