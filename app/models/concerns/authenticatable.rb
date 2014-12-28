# encoding: UTF-8
module Authenticatable
  extend ActiveSupport::Concern

  def add_provider(auth)
    social_network = SocialNetwork.find_by_provider(auth['provider'])

    accounts.build(
      social_network_id: social_network.id,
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

  def connected?(social_network)
    accounts.where(social_network_id: social_network.id).first
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
