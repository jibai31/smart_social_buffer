# encoding: utf-8
module Publisher
  extend ActiveSupport::Concern

  def publish(message)
    begin
      tweet = api.update(message.text)
    rescue => e
      return false
    end
    message.posts_count += 1
    message.content.posts_count += 1

    return tweet
  end

  private

  def api
    @api ||= Twitter::REST::Client.new(api_config)
  end

  def api_config
    TWITTER_CONFIG.merge({
      access_token: token,
      access_token_secret: token_secret
    })
  end

end
