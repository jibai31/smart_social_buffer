# encoding: UTF-8
module Authenticatable
  extend ActiveSupport::Concern

  def add_provider(auth)
    accounts.build(
      provider: auth['provider'],
      uid: auth['uid'],
      token: auth['credentials']['token'],
      token_secret: auth['credentials']['secret']
    )
  end

  def add_provider!(auth)
    add_provider(auth)
    save!
  end

  def connected?(provider)
    accounts.where(provider: provider).first
  end

  def connected_accounts
    @connected_accounts ||= SocialNetwork.build_list(accounts.map{|account| account.provider})
  end
end
