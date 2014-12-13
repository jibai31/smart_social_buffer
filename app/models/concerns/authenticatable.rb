# encoding: UTF-8
module Authenticatable
  extend ActiveSupport::Concern

  def add_provider(auth)
    accounts.build(
      provider: auth['provider'],
      uid: auth['uid'],
      username: retrieve_username(auth),
      email: auth['info']['email'],
      avatar: auth['info']['image'],
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

  private

  def retrieve_username(auth)
    provider = auth['provider']
    if provider == 'twitter'
      auth['info']['nickname']
    else
      auth['info']['name']
    end
  end
end
