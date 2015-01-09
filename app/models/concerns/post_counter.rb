# encoding: utf-8
module PostCounter
  extend ActiveSupport::Concern

  def increment_posts_count
    update_attributes(posts_count: posts_count + 1)
  end
end
