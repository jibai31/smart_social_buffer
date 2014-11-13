# encoding: UTF-8
class BufferedPost < ActiveRecord::Base
  belongs_to :message
  belongs_to :user
end
