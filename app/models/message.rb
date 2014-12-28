# encoding: UTF-8
class Message < ActiveRecord::Base
  belongs_to :content
  has_many :buffered_posts, dependent: :destroy
  belongs_to :social_network

  validates_presence_of :social_network_id

  # Class methods

  def self.less_posted
    order(:posts_count).first
  end

  # Instance methods

  def title
    content.title
  end
end
