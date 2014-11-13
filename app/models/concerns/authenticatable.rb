# encoding: UTF-8
module Authenticatable
  extend ActiveSupport::Concern

  def add_provider(auth)
    authentications.build(
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
    authentications.where(provider: provider).first
  end

  def connected_accounts
    @connected_accounts ||= SocialNetwork.build_list(authentications.map{|authentication| authentication.provider})
  end
end
