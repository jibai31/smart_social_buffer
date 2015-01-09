# encoding: UTF-8
class Content < ActiveRecord::Base
  # Concerns
  include PostCounter

  # Associations
  belongs_to :user
  belongs_to :category
  belongs_to :blog
  has_many :messages, dependent: :destroy

  # Validations
  validates_presence_of :url, :category_id

  # Class methods

  def self.with_messages_on(social_network_id)
    joins(:messages).where(messages: {social_network_id: social_network_id})
  end

  # Instance methods

  def create_default_messages
    user.accounts.implemented.each do |account|
      create_default_message(account.social_network)
    end
  end

  def create_default_message(social_network)
    msg = Message.new(
      content: self,
      social_network: social_network,
      post_only_once: post_only_once
    )
    msg.set_default_text(title, url)
    msg.save
  end

  def messages_on(social_network_id)
    messages.where(social_network_id: social_network_id)
  end
end
