# encoding: utf-8
module TweetMessage
  extend ActiveSupport::Concern

  included do
    validate :text_cannot_exceed_140_chars, if: Proc.new {|m| m.social_network.twitter? }
  end

  def text_cannot_exceed_140_chars
    errors.add(:text, "must be less than 140 characters") if overflow?
  end

  def overflow?
    display_length > 140
  end

  def display_length
    Twitter::Validation::tweet_length(text)
  end

  def chars_left
    140 - display_length
  end

  def set_default_text(title, url)
    self.text = "#{title} #{url}"

    too_many_chars = -chars_left
    if too_many_chars > 0
      truncate_after = title.length - too_many_chars
      new_title = title.truncate(truncate_after, omission: '…')
      self.text = "#{new_title} #{url}"
    end
  end
end
