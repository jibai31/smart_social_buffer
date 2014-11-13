# encoding: UTF-8
class Message < ActiveRecord::Base
  belongs_to :content
  has_many :buffered_posts
end
