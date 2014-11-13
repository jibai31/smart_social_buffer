# encoding: UTF-8

class Blog < ActiveRecord::Base
  # Concerns
  include HasContents

  # Associations
  belongs_to :user
  belongs_to :category

  # Validations
  validates_presence_of :url

  # Instance methods

  def to_s
    name || url
  end

  def feed_path
    @feed_path ||= url + '/feed'
  end

end
