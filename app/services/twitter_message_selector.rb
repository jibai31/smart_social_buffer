# encoding: utf-8
class TwitterMessageSelector

  def initialize(account)
    @account = account
  end

  attr_reader :account

  def best_message(content)
    pull_next_message(content)
  end

  def social_network
    account.provider
  end

  def store
    @store ||= init_store(account.contents)
  end

  private

  def init_store(contents)
    store = {}
    contents.each do |content|
      store[content] = content.messages.to_a
    end
    store
  end

  def pull_next_message(content)
    message = less_posted(content)
    store[content].delete(message)
  end

  def less_posted(content)
    store[content].min_by{|message| message.posts_count}
  end
end
