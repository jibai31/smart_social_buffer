# encoding: UTF-8
class Message < ActiveRecord::Base
  belongs_to :content
  has_many :buffered_posts, dependent: :destroy
  belongs_to :social_network

  validates_presence_of :social_network_id
  validate :text_cannot_exceed_140_chars, if: Proc.new {|m| m.social_network.twitter? }

  # Class methods

  def self.less_posted
    order(:posts_count).first
  end

  # Instance methods

  def title
    content.title
  end

  def display_length
    # Javascript: "café".normalize('NFC').length --> 4
    total_length = ActiveSupport::Multibyte::Chars.new(text).normalize(:c).length

    url = UrlParser.extract_url(text)
    if url.present?
      total_length = total_length - url.length + 22
    end

    return total_length
  end

  def text_cannot_exceed_140_chars
    if display_length > 140
      errors.add(:text, "must be less than 140 characters")
    end
  end
end
