# encoding: UTF-8
class Message < ActiveRecord::Base
  belongs_to :content
  has_many :buffered_posts

  # Class methods

  def self.less_posted
    order(:posts_count).first
  end
end
