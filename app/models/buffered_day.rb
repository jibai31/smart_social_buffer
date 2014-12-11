class BufferedDay < ActiveRecord::Base
  belongs_to :buffered_week
  has_many :buffered_posts, dependent: :destroy

  def posts_count
    buffered_posts.count
  end
end
