# encoding: UTF-8
class SocialNetwork

  def initialize(provider)
    @provider = provider
  end

  attr_reader :provider

  # Instance methods

  def to_s
    name
  end

  def code
    @code ||= provider.to_s.split('_').first
  end

  def name
    @name ||= code.capitalize
  end

  # Class methods

  def self.LIST
    @@social_network_list ||= build_list
  end

  def self.build_list(providers)
    providers ||= Devise.omniauth_configs.keys
    list = []
    providers.each do |social_network|
      list << SocialNetwork.new(social_network)
    end
    list
  end
end
