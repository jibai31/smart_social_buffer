# encoding: UTF-8

class Blog < ActiveRecord::Base
  # Concerns
  include HasContents

  # Associations
  belongs_to :user
  belongs_to :category
  scope :own_content, -> { where(category_id: 1) }
  scope :others, -> { where("category_id > 1") }

  # Validations
  validates_presence_of :url, :category_id

  # Instance methods

  def to_s
    name || url
  end

  def feed_path
    @feed_path ||= url + '/feed'
  end

end
