# encoding: UTF-8
class Message < ActiveRecord::Base
  # Concerns
  include TweetMessage
  include PostCounter

  # Associations
  belongs_to :content
  has_many :buffered_posts, dependent: :destroy
  belongs_to :social_network

  # Validations
  validates_presence_of :social_network_id
  validates :text, presence: true, allow_blank: false

  # Class methods

  def self.less_posted
    order(:posts_count).first
  end

  # Instance methods

  def title
    content.title
  end

end
