# encoding: UTF-8
class Content < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :blog
  has_many :messages, dependent: :destroy

  validates_presence_of :url

  def create_default_messages!
    user.connected_accounts.each do |social_network|
      create_default_message!(social_network)
    end
  end

  def create_default_message!(social_network)
    messages.create!(
      text: "#{title} #{url}",
      social_network: social_network.code,
      post_only_once: post_only_once
    )
  end
end
