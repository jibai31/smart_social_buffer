# encoding: UTF-8
require 'feedjira'

class FeedImporter

  def initialize(blog)
    @blog = blog
    @user = blog.user
    @feed = Feedjira::Feed.fetch_and_parse(blog.feed_path)
  end

  attr_reader :blog, :feed, :user

  def perform
    return false if !feed.respond_to?(:entries)

    feed.entries.each do |entry|
      if existing_content = find_existing_content(entry.url)
        existing_content.update_attributes(blog: blog)
      else
        create_content(entry)
      end
    end
  end

  private

  def find_existing_content(url)
    user.contents.find_by_url(url)
  end

  def create_content(entry)
    content = blog.contents.create(
      title: entry.title,
      url: entry.url,
      user: user,
      category: blog.category
    )
    content.create_default_messages
  end

end
